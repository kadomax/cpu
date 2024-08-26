
`include "sequencer.v"

module sequencer_tb();

reg clk_tb;
reg [3:0] opcode_tb;
wire [3:0] control_address_tb;
reg reset_sequencer_tb;


sequencer test_sequencer(
    .clk(clk_tb),
    .opcode(opcode_tb),
    .control_address(control_address_tb),
    .reset_sequencer(reset_sequencer_tb)
);

initial clk_tb = 1'b1;

always #5 clk_tb = ~clk_tb;

initial
begin
    $dumpfile("sequencer_gtk.vcd");
    $dumpvars(0 , sequencer_tb);
    reset_sequencer_tb = 1; opcode_tb = 4'b0000; #10; //control_address = 0000  count = 0
    reset_sequencer_tb = 1'b0; opcode_tb = 4'b0001; #10; //control_address = 0000 count = 1
    reset_sequencer_tb = 1'b0; opcode_tb = 4'b1010; #10; //control_address = 0010 count = 2
    reset_sequencer_tb = 1'b0; opcode_tb = 4'b1010; #10; //control_address = 0111 count = 0
    reset_sequencer_tb = 1'b0; opcode_tb = 4'b0101; #10; //control_address = 0000 count = 1
    reset_sequencer_tb = 1'b0; opcode_tb = 4'b1011; #10; //control_address = 0010 count = 2
    reset_sequencer_tb = 1'b0; opcode_tb = 4'b1010; #10; //control_address = 0111 count = 0
    $finish;
end

endmodule 