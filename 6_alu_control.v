module alu_control(
    input wire clk,
    input wire [1:0] alu_op,
    input wire [5:0] func_op,
    output reg [3:0] alu_control_sig
    );

// 4 bit ALU control signal taken from textbook Figure  4.13
always@(posedge clk)
begin

// Addi, Load/Store word
if (alu_op == 2'b00)
    alu_control_sig <= 4'b0010;

// Branch Equal
if (alu_op[0] == 0)
    alu_control_sig <= 4'b0110;

// R-type add
if (alu_op[1] == 1 && func_op[3:0] == 4'b0000)
    alu_control_sig <= 4'b0010;

// R-type sub
if (alu_op[1] == 1 && func_op[3:0] == 4'b0010)
    alu_control_sig <= 4'b0110;

// R-type and
if (alu_op[1] == 1 && func_op[3:0] == 4'b0100)
    alu_control_sig <= 4'b0000;

// R-type or
if (alu_op[1] == 1 && func_op[3:0] == 4'b0101)
    alu_control_sig <= 4'b0001;

// R-type slt
if (alu_op[1] == 1 && func_op[3:0] == 4'b1010)
    alu_control_sig <= 4'b0111;


end    
endmodule
