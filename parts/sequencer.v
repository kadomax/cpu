//`include "opcodes.vh"


module sequencer(clk , opcode , control_address , reset_sequencer);
input clk;
input[3:0] opcode;
output reg[3:0] control_address;
input reset_sequencer;
reg[1:0] count; //initial state of the counter should be 11

//states are 00 , 01 , 10
always @ (posedge clk , posedge reset_sequencer)
begin
    if(reset_sequencer == 1'b1)
        count <= 2'b00;
    else
    begin
        if(count == 2'b10)
            count <= 2'b00;
        else
            count <= count + 1'b1; 
    end
end

//assigning the control_address is combinational logic
always @ (count , opcode)
begin
    if(count == 2'b00)
        control_address = 4'b0000;
    else if(count == 2'b01)
        control_address = 4'b0001;
    else
    begin
        case(opcode)
            `ADD_OPCODE : control_address = 4'b0010;
            `SUB_OPCODE : control_address = 4'b0010;
            `AND_OPCODE : control_address = 4'b0010;
            `OR_OPCODE : control_address = 4'b0010;
            `XOR_OPCODE : control_address = 4'b0010;
            `B_OPCODE : control_address = 4'b0011;
            `BP_OPCODE : control_address = 4'b0011;
            `BN_OPCODE : control_address = 4'b0011;
            `BZ_OPCODE : control_address = 4'b0011;
            `LDRA_OPCODE : control_address = 4'b0100;
            `LDRB_OPCODE : control_address = 4'b0101;
            `LDRIA_OPCODE : control_address = 4'b0110;
            `LDRIB_OPCODE : control_address = 4'b0111;
            `STR_OPCODE : control_address = 4'b1000;
            `NOP_OPCODE :  control_address = 4'b1001;
            `HLT_OPCODE : control_address = 4'b1010;
            default : control_address = 4'b1010;
        endcase
    end
end

endmodule