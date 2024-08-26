//`include "opcodes.vh"


module instruction_register(clk , reset_ir , instruction , REIR , ir_opcode , ir_operand_or_addr);
input clk;
input reset_ir;
input [11:0] instruction;
input REIR;

output reg [3:0] ir_opcode;
output reg [7:0] ir_operand_or_addr;

always @ (posedge clk , posedge reset_ir)
begin
    if(reset_ir == 1'b1)
    begin
        ir_opcode <= 4'b0000;
        ir_operand_or_addr <= 8'b00000000;
    end
    
    else
    begin
        if(REIR == 1'b1)
        begin
            ir_opcode <= instruction[11:8];
            ir_operand_or_addr <= instruction[7:0];
        end
        else
        begin
            ir_opcode <= ir_opcode;
            ir_operand_or_addr <= ir_operand_or_addr;
        end
    end
end
endmodule