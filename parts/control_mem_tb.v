`include "control_mem.v"


module control_mem_tb();

reg clk_tb;
reg [3:0] control_addr_tb;
reg reset_control_word_tb;

wire [9:0] control_word_tb;

control_mem test_control_mem(
    .clk(clk_tb),
    .reset_control_word(reset_control_word_tb),
    .control_addr(control_addr_tb),
    .control_word(control_word_tb)
);

initial clk_tb <= 1'b1;
always #5 clk_tb <= ~clk_tb;

initial
begin
    $dumpfile("control_mem_gtk.vcd");
    $dumpvars(0 , control_mem_tb);
    reset_control_word_tb <= 1; control_addr_tb <= 0; #10;
    reset_control_word_tb <= 0 ; control_addr_tb <= 0; #10;
    reset_control_word_tb <= 0 ; control_addr_tb <= 4'b0001; #10;
    reset_control_word_tb <= 0 ; control_addr_tb <= 4'b0010; #10;
    $finish;
end


endmodule