module alu_control(clk, alu_op, func_op, alu_control_sig);

input wire [1:0] alu_op;
input wire [5:0] func_op;
input wire clk;

output reg [3:0] alu_control_sig;

// 4 bit ALU control signal taken from Figure 4.12
always@(posedge clk)
begin

// Load/Store word
if (alu_op == 2'b00)
    alu_control_sig <= 4'b0010;

// Branch Equal
if (alu_op == 2'b01)
    alu_control_sig <= 4'b0110;

// R-type add
if (alu_op == 2'b10 && func_op == 6'b100000)
    alu_control_sig <= 4'b0010;

// R-type sub
if (alu_op == 2'b10 && func_op == 6'b100010)
    alu_control_sig <= 4'b0110;

// R-type and
if (alu_op == 2'b10 && func_op == 6'b100100)
    alu_control_sig <= 4'b0000;

// R-type or
if (alu_op == 2'b10 && func_op == 6'b100101)
    alu_control_sig <= 4'b0001;


// R-type slt
if (alu_op == 2'b10 && func_op == 6'b101010)
    alu_control_sig <= 4'b0111;


end    
endmodule
