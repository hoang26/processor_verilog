
module Reg_Async_Reset_Enable (reset, enable, clk, in, out);

input reset, enable, clk;
input wire [31:0] in;
wire clk;

output reg [31:0] out;

always@(posedge clk)
    begin
    if (reset)
	out <= 0;
    else if (enable)
	out <= in;
    end

endmodule 