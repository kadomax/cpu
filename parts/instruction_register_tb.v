`include "instruction_register.v"


module instruction_register_tb();
reg clk_tb;
reg reset_ir_tb;
reg [11:0] instruction_tb;
reg REIR_tb;

wire [3:0] ir_opcode_tb;
wire [7:0] ir_operand_or_addr_tb;

instruction_register test_instruction_register(
    .clk(clk_tb), 
    .reset_ir(reset_ir_tb), 
    .instruction(instruction_tb), 
    .REIR(REIR_tb), 
    .ir_opcode(ir_opcode_tb), 
    .ir_operand_or_addr(ir_operand_or_addr_tb)
);

initial clk_tb <= 1'b1;
always #5 clk_tb <= ~clk_tb;

initial
begin
    $dumpfile("instruction_register_gtk.vcd");
    $dumpvars(0 , instruction_register_tb);
    reset_ir_tb = 1; instruction_tb = 12'b000011111111; REIR_tb = 0; #10;
    reset_ir_tb = 0; instruction_tb = 12'b010011111111; REIR_tb = 1; #10;
    $finish;
end


endmodule