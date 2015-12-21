// Program Counter modeled off HW6 Solutions Problem 2
module pc(
    input [31:0] in,
    input clk,
    input rst,
    input en,
    output reg [31:0] out);

always@(posedge clk or posedge rst)
begin
    if(rst)
        out <= 32'h00003000; // PC set to 0x00003000 if reset enabled
    else if(en)
        out <= in;
end

endmodule
