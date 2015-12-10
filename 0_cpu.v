//  Top-level processor module

module processor (input wire clk,
				  input wire pc_reset,
				  input wire pc_enable
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

wire [4:0] mux0_out;
wire [31:0] mux1_out;
wire [31:0] mux2_out;
wire [31:0] mux3_out;
wire [31:0] mux4_out;

wire [31:0] mem_data_out;

wire [31:0] add0_in1;
wire [31:0] pc_plus_four;

wire [31:0] alu_data_output;

wire [31:0] sl32_out;
wire [31:0] jump_addr;

wire [27:0] sl26_out;

wire [15:0] sign_ext_in;

wire [5:0] opcode;
wire [5:0] aluctrl_func_op;

wire [4:0] readReg1;
wire [4:0] readReg2;
wire [4:0] writeReg;

wire [3:0] alu_ctrl;

wire [1:0] alu_op;

wire reg_dst, jump, branch, mem_to_reg, ctrl_mem_read, ctrl_mem_write, alu_src, reg_write, adder_result, mux3_sel, mem_read, mem_write, zero;

assign add0_in1 = 32'd4;
assign jump_addr = {{pc_plus_four[31:28]}, {sl26_out[27:0]}};
assign aluctrl_func_op = instr[5:0];

assign mux3_sel =  branch & zero; // bit-wise AND

pc pc0(
	.in (pc_in), //32 bits
	.clk,
	.rst (pc_reset),
	.en (pc_enable),
	.out (pc_out) //32 bits
	);

// Moved control up here because mem_write from control feeds
// into mem_write for mem0
Control ctrl0(
	.clk,
	.opcode (instr[31:26]), //6 bits
	.reg_dst,
	.jump,
	.branch,
	.ctrl_mem_read,
	.mem_to_reg,
	.ctrl_mem_write,
	.alu_src,
	.reg_write,
	.alu_op //2 bits
	);

Memory mem0(
	.inst_addr (pc_out), //32 bits
	.instr,		//32 bits
	.data_addr (alu_data_output),	//32 bits
	.data_in (readData2), //32 bits
	.mem_read (ctrl_mem_read),
	.mem_write (ctrl_mem_write),
	.data_out (mem_data_out) //32 bits
	);

// adder for PC + 4
Adder_32b pc_adder(
	.clk,
	.input0 (pc_out),
	.input1 (add0_in1),
	.out (pc_plus_four)
	);

// Adder for shift left 2
Adder_32b adder1(
	.clk,
	.input0 (pc_plus_four),
	.input1 (sl32_out),
	.out (adder_result)
	);

reg_file registers(
	.clk,
	.regWrite (reg_write),
	.readReg1 (instr[25-21]), //5bits
	.readReg2 (instr[20-16]), //5bits
	.writeReg (mux0_out), //5bits
	.writeData (mux2_out), //32bits
	.readData1, //32bits
	.readData2 //32bits
	);

sign_extender signext0(
	.clk,
	.in (sign_ext_in), //16 bits
	.out (sign_ext_out) //32 bits
	);

// Need to combine sl26_out and highest 4 bits of PC+4
// to become the new sl26_out
Shift_left2_26b sl26(
	.clk,
	.in (instr[25:0]), //26bits
	.out (sl26_out) //28bits
	);

Shift_left2_32b sl32(
	.clk,
	.in (sign_ext_out), //32bits
	.out (sl32_out) //32bits
	);

// THIS NEEDS TO BE 5 BIT MUX
Mux2x1_5b Mux_RegDst(
	.clk,
	.input0 (instr[20:16]), //5bits
	.input1 (instr[15:11]), //5bits
	.select (reg_dst),
	.out (mux0_out) //5bits
	);

Mux2x1_32b Mux_ALUsrc(
	.clk,
	.input0 (readData2), //32bits
	.input1 (sign_ext_out), //32bits
	.select (alu_src),
	.out (mux1_out) //32bits
	);

Mux2x1_32b Mux_MemtoReg(
	.clk,
	.input0 (alu_data_output), //32bits
	.input1 (mem_data_out), //32bits
	.select (mem_to_reg),
	.out (mux2_out) //32bits
	);

Mux2x1_32b Mux_Branch(
	.clk,
	.input0 (pc_plus_four), //32bits
	.input1 (adder_result), //32bits
	.select (mux3_sel),
	.out (mux3_out) //32bits
	);

Mux2x1_32b Mux_Jump(
	.clk,
	.input0 (mux3_out), //32bits
	.input1 (jump_addr), //32bits
	.select (jump),
	.out (pc_in) //32bits
	);

alu_control aluctrl(
	.clk,
	.alu_op, //2bits
	.func_op (aluctrl_func_op), //6bits
	.alu_control_sig (alu_ctrl) //4bits
	);

ALU alu0(
	.clk,
	.control (alu_ctrl), //4bits
	.data_input1 (readData1), //32bits
	.data_input2 (mux1_out), //32bits
	.data_output (alu_data_output), //32bits
	.zero
	);

// Considerations: Reordering of modules to reduce clock cycles

endmodule
