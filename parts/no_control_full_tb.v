`include "no_contorl_full.v"

module no_control_full_tb();

reg clk_tb , reset_full_tb;
reg HLT_tb , INC_tb , REPC_tb , REIR_tb , REDMEM_tb , RER_tb;
reg [1:0] cu_A_tb;
reg [1:0] cu_B_tb;

no_control_full test_no_control_full(
    .clk(clk_tb),
    .reset_full(reset_full_tb),
    .HLT(HLT_tb),
    .INC(INC_tb),
    .REPC(REPC_tb),
    .REIR(REIR_tb),
    .REDMEM(REDMEM_tb),
    .RER(RER_tb),
    .cu_A(cu_A_tb), 
    .cu_B(cu_B_tb)
);

initial clk_tb <= 1'b1;
always #5 clk_tb <= ~clk_tb;

initial
begin
    $dumpfile("no_control_full_gtk.vcd");
    $dumpvars(0 , no_control_full_tb);
    //extra cycle is needed after reset for the cpu to work properly
    reset_full_tb <= 1; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10;
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10;

    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 1; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 1; REPC_tb <= 1; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b11; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 1; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 1; REPC_tb <= 1; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b11; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 1; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 1; REPC_tb <= 1; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 0; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    reset_full_tb <= 0; HLT_tb <= 0; INC_tb <= 0; REPC_tb <= 0; REIR_tb <= 0; REDMEM_tb <= 0; RER_tb <= 1; cu_A_tb <= 2'b00; cu_B_tb <= 2'b00; #10; //
    $finish;
end


endmodule