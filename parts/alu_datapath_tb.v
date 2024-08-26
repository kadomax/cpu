`include "alu_datapath.v"


module alu_datapath_tb();
reg [7:0] dmem_data_tb;
reg [7:0] ir_operand_tb;
reg [1:0] cu_A_tb;
reg [1:0] cu_B_tb;
reg [3:0] opcode_tb;
reg RER_tb;

reg clk_tb;
reg reset_alu_datapath_tb;

wire [7:0] R_tb;

alu_datapath test_alu_datapath(
    .reset_alu_datapath(reset_alu_datapath_tb),
    .clk(clk_tb),
    .dmem_data(dmem_data_tb),
    .ir_operand(ir_operand_tb),
    .cu_A(cu_A_tb),
    .cu_B(cu_B_tb), 
    .opcode(opcode_tb), 
    .RER(RER_tb), 
    .R(R_tb) //output
);

initial clk_tb <= 1'b1;
always #5 clk_tb = ~clk_tb;

initial
begin
    $dumpfile("alu_datapath_gtk.vcd");
    $dumpvars(0 , alu_datapath_tb);
    reset_alu_datapath_tb = 1; dmem_data_tb = 0; ir_operand_tb = 0; cu_A_tb = 0; cu_B_tb = 0; opcode_tb = 0; RER_tb = 0; #10; //reset value
    reset_alu_datapath_tb = 0; dmem_data_tb = 8'b01010101; ir_operand_tb = 0; cu_A_tb = 2'b10; cu_B_tb = 0; opcode_tb = 0; RER_tb = 0; #10; //dmem_data -> A
    reset_alu_datapath_tb = 0; dmem_data_tb = 8'b01010100; ir_operand_tb = 0; cu_A_tb = 0; cu_B_tb = 2'b10; opcode_tb = 0; RER_tb = 0; #10; //dmem_data->B
    reset_alu_datapath_tb = 0; dmem_data_tb = 0; ir_operand_tb = 0; cu_A_tb = 0; cu_B_tb = 0; opcode_tb = 4'b0000; RER_tb = 1; #10; //ADD A, B
    reset_alu_datapath_tb = 0; dmem_data_tb = 0; ir_operand_tb = 8'b10101010; cu_A_tb = 2'b11; cu_B_tb = 0; opcode_tb = 0; RER_tb = 0; #10; //A <= ir_operand
    reset_alu_datapath_tb = 0; dmem_data_tb = 0; ir_operand_tb = 8'b11111100; cu_A_tb = 0; cu_B_tb = 2'b11; opcode_tb = 0; RER_tb = 0; #10; //B <= ir_operand
    $finish;
end

endmodule