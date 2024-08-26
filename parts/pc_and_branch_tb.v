`include "pc_and_branch_new.v"


module PC_and_branch_tb();
reg clk_tb;
reg reset_pc_tb;
reg REPC_tb;
reg [3:0] ir_opcode_tb;
reg INC_tb;
reg [7:0] R_val_tb;
reg [7:0] ir_operand_addr_tb;

wire [9:0] pc_tb;

PC_and_branch test_PC_and_branch(
    .clk(clk_tb),
    .reset_pc(reset_pc_tb),
    .REPC(REPC_tb),
    .ir_opcode(ir_opcode_tb),
    .INC(INC_tb),
    .R_val(R_val_tb),
    .ir_operand_addr(ir_operand_addr_tb),
    .pc(pc_tb)
);

initial clk_tb <= 1'b1;
always #5 clk_tb <= ~clk_tb;

initial
begin
    $dumpfile("pc_and_branch_gtk.vcd");
    $dumpvars(0 , PC_and_branch_tb);
    reset_pc_tb = 1; REPC_tb = 0; ir_opcode_tb = 0; INC_tb = 0; R_val_tb = 0; ir_operand_addr_tb = 0; #10; //reset pc
    reset_pc_tb = 0; REPC_tb = 1; ir_opcode_tb = 0; INC_tb = 1; R_val_tb = 0; ir_operand_addr_tb = 0; #10; //inc pc
    reset_pc_tb = 0; REPC_tb = 1; ir_opcode_tb = 4'b0101; INC_tb = 0; R_val_tb = 0; ir_operand_addr_tb = 8'b01010101; #10; //uncond branch
    reset_pc_tb = 0; REPC_tb = 1; ir_opcode_tb = 4'b1000; INC_tb = 0; R_val_tb = 8'b00000000; ir_operand_addr_tb = 8'b10101010; #10; //BZ
    $finish;
end


endmodule