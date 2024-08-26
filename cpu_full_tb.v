`include "cpu_full.v"

module cpu_full_tb();
reg clk_external_tb , reset_full_tb;

cpu_full test_cpu_full(
    .clk_external(clk_external_tb),
    .reset_full(reset_full_tb)
);

initial clk_external_tb <= 1'b1;
always #5 clk_external_tb <= ~clk_external_tb;

initial
begin
    $dumpfile("cpu_full_gtk.vcd");
    $dumpvars(0 , cpu_full_tb);
    reset_full_tb <= 1; #10;
    reset_full_tb <= 0; #10;
    reset_full_tb <= 0; #500;
    $finish;
end

endmodule