`include "opcodes.vh"
`include "parts/alu_datapath.v"
`include "parts/dmem.v"
`include "parts/pc_and_branch_new.v"
`include "parts/instruction_memory.v"
`include "parts/instruction_register.v"
`include "parts/sequencer.v"
`include "parts/control_mem.v"

module cpu_full(clk_external , reset_full);
input clk_external , reset_full;

wire [7:0] data_memory_output;
wire [7:0] instruction_reg_operand_output;
wire [3:0] instruction_reg_opcode_output;
wire [7:0] R_alu_datapath_output;
wire [9:0] pc_and_branch_logic_output;
wire [11:0] instruction_output_from_imem;
wire [3:0] control_mem_addr_from_sequencer;
wire [9:0] control_mem_out;

//control signals
wire HLT, INC, REPC, REIR, REDMEM, RER;
wire [1:0] cu_A;
wire [1:0] cu_B;

wire clk;

assign cu_A = control_mem_out[3:2];
assign cu_B = control_mem_out[1:0];
assign RER = control_mem_out[4];
assign REDMEM = control_mem_out[5];
assign REIR = control_mem_out[6];
assign REPC = control_mem_out[7];
assign INC = control_mem_out[8];
assign HLT = control_mem_out[9];

assign clk = HLT ? 1'b0 : clk_external;

alu_datapath alu_datapath_full(
    .reset_alu_datapath(reset_full),
    .clk(clk), 
    .dmem_data(data_memory_output), //input from the data memory
    .ir_operand(instruction_reg_operand_output), //input operand from instruction register
    .cu_A(cu_A),
    .cu_B(cu_B),
    .opcode(instruction_reg_opcode_output), //input opcode from instruction register
    .RER(RER), 
    .R(R_alu_datapath_output) //R reg output from alu_datapath
);

dmem dmem_full(
    .reset_dmem(reset_full),
    .clk(clk),
    .dmem_addr(instruction_reg_operand_output), //input from operand of instruction register  
    .read_val(R_alu_datapath_output), //input from R register of alu_datapath
    .REDMEM(REDMEM), 
    .data(data_memory_output) //output from data memory
);

PC_and_branch PC_and_branch_full(
    .clk(clk), 
    .reset_pc(reset_full), 
    .REPC(REPC),
    .ir_opcode(instruction_reg_opcode_output), //input from ir opcode field
    .INC(INC),
    .R_val(R_alu_datapath_output), //input from R reg of alu_datapath
    .ir_operand_addr(instruction_reg_operand_output), //input from ir operand field
    .pc(pc_and_branch_logic_output) //output from pc_and_branch_logic
);

instruction_memory instruction_memory_full(
    .clk(clk), 
    .reset_instruction(reset_full),
    .instruction_addr_pc(pc_and_branch_logic_output),
    .instruction(instruction_output_from_imem) //12-bit instruction output from instruction memory
);

instruction_register instruction_register_full(
    .clk(clk),
    .reset_ir(reset_full),
    .instruction(instruction_output_from_imem), //12-bit instruction input from instruction memory
    .REIR(REIR), 
    .ir_opcode(instruction_reg_opcode_output), //output opcode from the instruction register
    .ir_operand_or_addr(instruction_reg_operand_output) //output operand from the instruction register
);

sequencer sequencer_full(
    .clk(clk),
    .opcode(instruction_reg_opcode_output),
    .control_address(control_mem_addr_from_sequencer), //output from sequencer
    .reset_sequencer(reset_full)
);

control_mem control_mem_full(
    .clk(clk),
    .reset_control_word(reset_full),
    .control_addr(control_mem_addr_from_sequencer),
    .control_word(control_mem_out) //output from control memory
);

endmodule