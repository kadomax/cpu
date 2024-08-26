//`include "opcodes.vh"

module instruction_memory(clk , reset_instruction , instruction_addr_pc , instruction);
input clk;
input reset_instruction;
input [9:0] instruction_addr_pc;

output reg [11:0] instruction;

reg [11:0] instruction_buffer [1023 : 0];

initial
begin
    $readmemb("test_instructions.txt" , instruction_buffer);
end

always @ (posedge clk, posedge reset_instruction)
begin

    if(reset_instruction == 1'b1)
        instruction <= 12'b000000000000;
    else
    begin
        instruction <= instruction_buffer[instruction_addr_pc];        
    end
end
endmodule