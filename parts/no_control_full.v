`include "opcodes.vh"
`include "parts/alu_datapath.v"
`include "parts/dmem.v"
`include "parts/pc_and_branch.v"
`include "parts/instruction_memory.v"
`include "parts/instruction_register.v"

module no_control_full(clk , reset_full , HLT , INC , REPC , REIR , REDMEM , RER , cu_A , cu_B);
input clk , reset_full;
input HLT , INC , REPC , REIR , REDMEM , RER;
input [1:0] cu_A;
input [1:0] cu_B;

wire [7:0] data_memory_output;
wire [7:0] instruction_reg_operand_output;
wire [3:0] instruction_reg_opcode_output;
wire [7:0] R_alu_datapath_output;
wire [9:0] pc_and_branch_logic_output;
wire [11:0] instruction_output_from_imem;
wire [3:0] control_mem_addr_from_sequencer;

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

endmodule