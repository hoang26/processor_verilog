module Control(
    input wire [5:0] opcode,
    input wire clk,
    output reg reg_dst,
    output reg jump,
    output reg branch,
    output reg ctrl_mem_read,
    output reg mem_to_reg,
    output reg ctrl_mem_write,
    output reg alu_src,
    output reg reg_write,
    output reg [1:0] alu_op
    );

// Control signals from FIgure 4.18, 4.22, & Ref Sheet
always@(posedge clk)
begin

// Initalize signals to 0 to reduce redundancy in if statements
{reg_dst, alu_src, mem_to_reg, reg_write, ctrl_mem_read, ctrl_mem_write, branch, jump, alu_op} = 10'b0000000000;

// R-type
if (opcode == 6'b000000) begin
    reg_dst <= 1;
    reg_write <= 1;
    alu_op <= 2'b10;
end
    

// Load word
else if (opcode == 6'b100011) begin
    alu_src <= 1;
    mem_to_reg <= 1;
    reg_write <= 1;
    ctrl_mem_read <= 1;
end

// Store word
else if (opcode == 6'b101011) begin
    alu_src <= 1;
    ctrl_mem_write <= 1;
end

// Branch equal
else if (opcode == 6'b000100) begin
    branch <= 1;
    alu_op <= 2'b01;
end

// Addi
if (opcode == 6'b001000) begin
    alu_src <= 1;
    reg_write <= 1;
    // alu_op <= 2'b10;
end

// Jump
else if (opcode == 6'b000010) begin
    jump <= 1;
end

end
endmodule
