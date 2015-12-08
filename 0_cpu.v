//  Top-level processor module

module processor (input wire clk,
				  input wire reset
			     );

wire [31:0] pc_in;
wire [31:0] pc_out;
wire [31:0] inst_addr;
wire [31:0] instr;
wire [31:0] data_addr;
wire [31:0] data_in;
wire [31:0] data_out;
wire [31:0] writeData;
wire [31:0] readData1;
wire [31:0] readData2;
wire [31:0] sign_ext_out;

wire [31:0] mux0_in0;
wire [31:0] mux0_in1;
wire [31:0] mux0_out;
wire [31:0] mux1_in0;
wire [31:0] mux1_in1;
wire [31:0] mux1_out;
wire [31:0] mux2_in0;
wire [31:0] mux2_in1;
wire [31:0] mux2_out;
wire [31:0] mux3_in0;
wire [31:0] mux3_in1;
wire [31:0] mux3_out;
wire [31:0] mux4_in0;
wire [31:0] mux4_in1;
wire [31:0] mux4_out;

wire [31:0] alu_data_input1;
wire [31:0] alu_data_input2;
wire [31:0] alu_data_output;

wire [31:0] sl32_in;
wire [31:0] sl32_out;

wire [25:0] sl26_in;
wire [25:0] sl26_out;

wire [15:0] sign_ext_in;

wire [5:0] opcode;
wire [5:0] aluctrl_func_op;

wire [4:0] readReg1;
wire [4:0] readReg2;
wire [4:0] writeReg;

wire [3:0] aluctrl_alu_control_sig, alu_ctrl;

wire [1:0] alu_op, aluctrl_alu_op;

wire pc_reset, pc_en, mem_mem_read, mem_mem_write, reg_dst, jump, branch, mem_to_reg, ctrl_mem_read, ctrl_mem_write, alu_src, reg_write, add0_in0, add0_in1, add0_out,
     add1_in0, add1_in1, add1_out, reg_reg_write, mux0_sel, mux1_sel, mux2_sel, mux3_sel, mux4_sel, zero;






pc pc0(
	.in (pc_in), //32 bits
	.clk,
	.rst (pc_reset),
	.en (pc_en),
	.out (pc_out) //32 bits
	);

Memory mem0(
	.clk,
	.inst_addr, //32 bits
	.instr,		//32 birs
	.data_addr,	//32 bits
	.data_in (mem_data_in), //32 bits
	.mem_read (mem_mem_read),
	.mem_write (mem_mem_write),
	.data_out (mem_data_out) //32 bits
	);

Control ctrl0(
	.clk,
	.opcode, //6 bits
	.reg_dst,
	.jump,
	.branch,
	.mem_read (ctrl_mem_read),
	.mem_to_reg,
	.mem_write (ctrl_mem_write),
	.alu_src,
	.reg_write,
	.alu_op //2 bits
	);

// adder for PC + 4
Adder_32b pc_adder(
	.clk,
	.input0 (add0_in0),
	.input1 (add0_in1),
	.out (add0_out)
	);

// Adder for shift left 2
Adder_32b adder1(
	.clk,
	.input0 (add1_in0),
	.input1 (add1_in1),
	.out (add1_out)
	);

reg_file registers(
	.clk,
	.regWrite (reg_reg_write),
	.readReg1, //5bits
	.readReg2, //5bits
	.writeReg, //5bits
	.writeData, //32bits
	.readData1, //32bits
	.readData2 //32bits
	);

sign_extender signext0(
	.clk,
	.in (sign_ext_in), //16 bits
	.out (sign_ext_out) //32 bits
	);

Shift_left2_26b sl26(
	.clk,
	.in (sl26_in), //26bits
	.out (sl26_out) //26bits
	);

Shift_left2_32b sl32(
	.clk,
	.in (sl32_in), //26bits
	.out (sl32_out) //26bits
	);

Mux2x1_32b mux0(
	.clk,
	.input0 (mux0_in0), //32bits
	.input1 (mux0_in1), //32bits
	.select (mux0_sel),
	.out (mux0_out) //32bits
	);

Mux2x1_32b mux1(
	.clk,
	.input0 (mux1_in0), //32bits
	.input1 (mux1_in1), //32bits
	.select (mux1_sel),
	.out (mux1_out) //32bits
	);

Mux2x1_32b mux2(
	.clk,
	.input0 (mux2_in0), //32bits
	.input1 (mux2_in1), //32bits
	.select (mux2_sel),
	.out (mux2_out) //32bits
	);

Mux2x1_32b mux3(
	.clk,
	.input0 (mux3_in0), //32bits
	.input1 (mux3_in1), //32bits
	.select (mux3_sel),
	.out (mux3_out) //32bits
	);

Mux2x1_32b mux4(
	.clk,
	.input0 (mux4_in0), //32bits
	.input1 (mux4_in1), //32bits
	.select (mux4_sel),
	.out (mux4_out) //32bits
	);

alu_control aluctrl(
	.clk,
	.alu_op (aluctrl_alu_op), //2bits
	.func_op (aluctrl_func_op), //6bits
	.alu_control_sig (aluctrl_alu_control_sig) //4bits
	);

ALU alu0(
	.clk,
	.control (alu_ctrl), //4bits
	.data_input1 (alu_data_input1), //32bits
	.data_input2 (alu_data_input2), //32bits
	.data_output (alu_data_output), //32bits
	.zero
	);


// Considerations: Reordering of modules to reduce clock cycles

endmodule
