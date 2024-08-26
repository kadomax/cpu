//`include "opcodes.vh"
//this does not work.
//use pc_and_branch_new.v instead of this one
//DONT USE THIS FILE. IT IS HERE FOR REFERENCE PURPOSES.

module PC_and_branch(clk , reset_pc , REPC , ir_opcode , INC , R_val , ir_operand_addr , pc);
input clk;
input reset_pc;
input REPC;
input [3:0] ir_opcode;
input INC;
input [7:0] R_val;
input [7:0] ir_operand_addr;

output reg [9:0] pc;

always @ (posedge clk , posedge reset_pc)
begin
    if(reset_pc == 1'b1)
        pc <= 10'b0000000000;
    
    else
    begin
        if(REPC == 1'b1)
        begin
            if(INC == 1'b1)
                pc <= pc + 1;
            else
            begin
                case(ir_opcode)
                    `B_OPCODE :
                        begin
                            pc <= pc + ir_operand_addr;
                        end
                    `BP_OPCODE : 
                        begin
                            if(R_val[7] == 1'b0)
                                pc <= pc + ir_operand_addr;
                            else
                                pc <= pc;
                        end
                    `BN_OPCODE :
                        begin
                            if(R_val[7] == 1'b1)
                                pc <= pc + ir_operand_addr;
                            else
                                pc <= pc;
                        end
                    `BZ_OPCODE :
                        begin
                            if(R_val == 8'b00000000)
                                pc <= pc + ir_operand_addr;
                            else
                                pc <= pc;
                        end
                    default : pc <= pc;
                endcase
            end      
        end
        else
            pc <= pc;
    end
end

endmodule