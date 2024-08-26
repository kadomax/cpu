`include "dmem.v"


module dmem_tb();

reg [7:0] dmem_addr_tb; 
reg [7:0] read_val_tb; 
reg REDMEM_tb; 
reg clk_tb;
reg reset_dmem_tb;
wire [7:0] data_tb;

dmem dmem_test(
    .reset_dmem(reset_dmem_tb),
    .clk(clk_tb),
    .dmem_addr(dmem_addr_tb),
    .read_val(read_val_tb),
    .REDMEM(REDMEM_tb),
    .data(data_tb)
);

initial clk_tb <= 1'b1;

always #5 clk_tb = ~clk_tb;

initial
begin
    $dumpfile("dmem_gtk.vcd");
    $dumpvars(0 , dmem_tb);
    reset_dmem_tb = 1; #10; //data = 0
    reset_dmem_tb = 0; REDMEM_tb = 1; dmem_addr_tb = 8'b00000000 ;read_val_tb = 8'b01010101; #10; //data = 0
    reset_dmem_tb = 0; REDMEM_tb = 0 ; dmem_addr_tb = 8'b00000000; read_val_tb = 8'b01010101; #10; //data = 01010101
    $finish;
end

endmodule