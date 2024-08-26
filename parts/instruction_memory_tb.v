`include "instruction_memory.v"

module instruction_memory_tb();

reg clk_tb;
reg reset_instruction_tb;
reg [9:0] instruction_addr_pc_tb;

wire [11:0] instruction_tb;

instruction_memory test_instruction_memory(
    .clk(clk_tb),
    .reset_instruction(reset_instruction_tb),
    .instruction_addr_pc(instruction_addr_pc_tb),
    .instruction(instruction_tb)
);

initial clk_tb <= 1'b1;
always #5 clk_tb <= ~clk_tb;

initial
begin
    $dumpfile("instruction_memory_gtk.vcd");
    $dumpvars(0 , instruction_memory_tb);
    reset_instruction_tb <= 1'b1; instruction_addr_pc_tb <= 10'b0101010101; #10; //instruction reset
    reset_instruction_tb <= 1'b0; instruction_addr_pc_tb <= 10'b0101010101; #10; //load from instruction_addr_pc
    $finish;
end


endmodule