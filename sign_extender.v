module sign_extender(clk, in, out);

input wire clk;
input wire [15:0] in;

output reg [31:0] out;

always@(posedge clk)
    begin
        out <= {{16{in[15]}}, in[15:0]};
    end
	
endmodule
