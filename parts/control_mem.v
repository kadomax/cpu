//`include "opcodes.vh"

//sequence for control signals is
//HLT , INC , REPC , REIR , REDMEM , RER , cu_A , cu_B
//cu_A and cu_B are both two bits wide

module control_mem(clk  , reset_control_word , control_addr , control_word);

input clk;
input [3:0] control_addr;
input reset_control_word;
reg [9:0] control_buffer [10:0];

output reg [9:0] control_word;

initial
begin
    $readmemb("control_mem_image.txt" , control_buffer);
end

always @ (posedge clk , posedge reset_control_word)
begin
    if(reset_control_word == 1'b1)
    begin
        control_word <= 4'b0000;
    end
    else
        control_word <= control_buffer[control_addr];
end

endmodule