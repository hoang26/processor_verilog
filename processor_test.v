module processor_test (input wire clk,
				  input wire pc_reset,
				  input wire pc_enable
			     );

// Step 1
wire [31:0] pc_in;
wire [31:0] pc_out;

// Step 2
wire [31:0] pc_plus_four;

assign add0_in1 = 32'd4;

// Step 3
wire [31:0] alu_data_output;
wire [31:0] readData2;
wire ctrl_mem_read;
wire ctrl_mem_write;
wire [31:0] mem_data_out;

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

//******************* STEP 3 - INSTRUCTION MEM *******************************
Memory mem0(
	.inst_addr (pc_out), //32 bits
	.instr,		//32 bits
	.data_addr (alu_data_output),	//32 bits
	.data_in (readData2), //32 bits
	.mem_read (ctrl_mem_read),
	.mem_write (ctrl_mem_write),
	.data_out (mem_data_out) //32 bits
	);

endmodule
