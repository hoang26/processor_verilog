module processor_test (input wire clk,
				  input wire pc_reset,
				  input wire pc_enable
			     );

wire [31:0] pc_in;
wire [31:0] pc_out;

assign add0_in1 = 32'd4;

//************************ STEP 1 - PC ************************************
pc pc0(
	.in (pc_in), //32 bits
	.clk,
	.rst (pc_reset),
	.en (pc_enable),
	.out (pc_out) //32 bits
	);

//******************** STEP 2 - PC + 4 ADDER ********************************
Adder_32b pc_adder(
	.clk,
	.input0 (pc_out),
	.input1 (add0_in1),
	.out (pc_plus_four)
	);

endmodule
