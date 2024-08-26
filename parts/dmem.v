module dmem(reset_dmem , clk , dmem_addr ,  read_val , REDMEM , data);

input [7:0] dmem_addr; //from the ir
input [7:0] read_val; //from register R
input REDMEM; //control signal
input clk;
input reset_dmem;
output reg [7:0] data;

reg [7:0] buffer [255 : 0];

always @ (posedge clk , posedge reset_dmem)
begin
    if(reset_dmem == 1'b1)
        data <= 8'b00000000;
    else
    begin
        if(REDMEM == 1'b1)
        begin
            buffer[dmem_addr] <= read_val;
            data <= 8'b00000000;
        end
        else
        begin
            data <= buffer[dmem_addr];
        end
    end
end

endmodule