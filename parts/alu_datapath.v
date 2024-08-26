//`include "opcodes.vh"

module alu_datapath(reset_alu_datapath , clk , dmem_data , ir_operand , cu_A , cu_B , opcode , RER , R);

input [7:0] dmem_data;
input [7:0] ir_operand;
input [1:0] cu_A;
input [1:0] cu_B;
input [3:0] opcode;
input RER;

input clk;
input reset_alu_datapath;

output reg [7:0] R;

reg [7:0] A;
reg [7:0] B;

always @ (posedge clk , posedge reset_alu_datapath)
begin
    if(reset_alu_datapath == 1'b1)
        R <= 8'b00000000;
    else
    begin
        if(RER == 1'b1)
        begin
            case(opcode)
                `ADD_OPCODE : R <= A + B;
                `SUB_OPCODE : R <= A - B;
                `AND_OPCODE : R <= A & B;
                `OR_OPCODE : R <= A | B;
                `XOR_OPCODE : R <= A ^ B; 
                default : R <= 8'b00000000;
            endcase
        end
        else
            R <= R;
    end
end

always @ (posedge clk , posedge reset_alu_datapath)
begin
    if(reset_alu_datapath == 1'b1)
        A <= 8'b00000000;
    else
    begin
        case(cu_A)
            2'b00 : A <= A;
            2'b01 : A <= A;
            2'b10 : A <= dmem_data;
            2'b11 : A <= ir_operand;
            default : A <= A;
        endcase
    end
end

always @ (posedge clk , posedge reset_alu_datapath)
begin
    if(reset_alu_datapath == 1'b1)
        B <= 8'b00000000;
    else
    begin
        case(cu_B)
            2'b00 : B <= B;
            2'b01 : B <= B;
            2'b10 : B <= dmem_data;
            2'b11 : B <= ir_operand;
            default : B <= B;
        endcase
    end
end

endmodule