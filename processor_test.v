module processor_test (input wire clk,
				  input wire pc_reset,
				  input wire pc_enable
			     );

wire [31:0] pc_in;
wire [31:0] pc_out;

pc pc0(
	.in (pc_in), //32 bits
	.clk,
	.rst (pc_reset),
	.en (pc_enable),
	.out (pc_out) //32 bits
	);
