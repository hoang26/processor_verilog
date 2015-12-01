// Taken from HW6 solutions
module pc(input [31:0] in,
				input clk,
				input rst,
				input en,
				output reg [31:0] out);

always@(posedge clk or posedge rst)
begin
	if(rst)
		out <= 32'h00003000; //requirement stated in project assignment
	else if(en)
		out <= in;
end

endmodule
