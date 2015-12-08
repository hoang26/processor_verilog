module Mux2x1_32b (clk, input0, input1, select, out);

    input wire [31:0] input0;
	input wire [31:0] input1;
	input wire clk, select;

    output reg [31:0] out;

	always@(posedge clk)
	begin
	    if (select)
            out <= input1;
		else if (!select)
		    out <= input0;
	end
endmodule
