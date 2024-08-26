//`include "opcodes.vh"

//pc_and_branch.v does not work, dont use it.
//the change made here is that the pc is incremented depending on the opcode in the fetch phase itself
//the control memory for the branch instruction is similar to nop eventhough it may have one control signal high
//the control signal that is high is the INC control signal which does not do anything.
//it is there because pc_and_branch.v(which we are not using) needed it.
//it is not removed because removing it would mean the control memory and sequencer both have to be changed which would be a pain.

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
                            if(R_val[7] == 1'b1) //akshay modak
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
                    default : pc <= pc + 1'b1;
                endcase
            else
            begin
                pc <= pc;
            end      
        end
        else
            pc <= pc;
    end
end

endmodule