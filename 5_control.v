module Control(clk, opcode, reg_dst, jump, branch, ctrl_mem_read, mem_to_reg, ctrl_mem_write, alu_src, reg_write, alu_op);

input wire [5:0] opcode;
input wire clk;

output reg reg_dst, jump, branch, ctrl_mem_read, mem_to_reg, ctrl_mem_write, alu_src, reg_write;
output reg [1:0] alu_op;


// Control signals from FIgure 4.18, 4.22, & Ref Sheet
always@(posedge clk)
begin

// R-format
if (opcode == 6'b000000) begin
    reg_dst <= 1;
    alu_src <= 0;
    mem_to_reg <= 0;
    reg_write <= 1;
    ctrl_mem_read <= 0;
    ctrl_mem_write <= 0;
    branch <= 0;
    jump <= 0;
    alu_op <= 2'b10;
end
    

// Load word
else if (opcode == 6'b100011) begin
    reg_dst <= 0;
    alu_src <= 1;
    mem_to_reg <= 1;
    reg_write <= 1;
    ctrl_mem_read <= 1;
    ctrl_mem_write <= 0;
    branch <= 0;
    jump <= 0;
    alu_op <= 2'b00;
end

// Store word
else if (opcode == 6'b101011) begin
    // reg_dst <= Dont care
    alu_src <= 1;
    //mem_to_reg <= Dont care
    reg_write <= 0;
    ctrl_mem_read <= 0;
    ctrl_mem_write <= 1;
    branch <= 0;
    jump <= 0;
    alu_op <= 2'b00;
end

// Branch equal
else if (opcode == 6'b000100) begin
    // reg_dst <= Don't care
    alu_src <= 0;
    // mem_to_reg <= Don't care
    reg_write <= 0;
    ctrl_mem_read <= 0;
    ctrl_mem_write <= 0;
    branch <= 1;
    jump <= 0;
    alu_op <= 2'b01;
end

// Addi
if (opcode == 6'b001000) begin
    reg_dst <= 0;
    alu_src <= 1;
    mem_to_reg <= 0;
    reg_write <= 1;
    ctrl_mem_read <= 0;
    ctrl_mem_write <= 0;
    branch <= 0;
    jump <= 0;
    alu_op <= 2'b10;
end

// Jump
else if (opcode == 6'b000010) begin
    reg_dst <= 0;
    alu_src <= 0;
    mem_to_reg <= 0;
    reg_write <= 0;
    ctrl_mem_read <= 0;
    ctrl_mem_write <= 0;
    branch <= 0;
    jump <= 1;
    alu_op <= 2'b00;
end

end
endmodule
