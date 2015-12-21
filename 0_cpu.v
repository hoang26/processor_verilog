//  Top-level processor module

module processor(
    input clk,
    input pc_reset,
    input pc_enable,
    input [31:0] instr,
    input [31:0] data_out,
    output wire[31:0] data_in,
    output wire[31:0] inst_addr,
    output wire[31:0] data_addr,
    output wire mem_read_ctrlsig,
    output wire mem_write_ctrlsig
    );

// Wire instantiations for port connections between modules
wire [31:0] pc_in;
wire [31:0] pc_out;

wire [31:0] readData1;
wire [31:0] readData2;
wire [31:0] sign_ext_out;

wire [4:0] reg_dst_out;
wire [31:0] alu_src_out;
wire [31:0] mem_to_reg_out;
wire [31:0] branch_out;

wire [31:0] add0_in1;
wire [31:0] pc_plus_four;
wire [31:0] adder_result;

wire [31:0] alu_data_output;

wire [31:0] sl32_out;
wire [31:0] jump_addr;

wire [25:0] sl26_in;
wire [27:0] sl26_out;

wire [15:0] sign_ext_in;

wire [5:0] opcode;
wire [5:0] aluctrl_func_op;

wire [4:0]reg_dst_input0;
wire [4:0]reg_dst_input1;

wire [4:0] readReg1;
wire [4:0] readReg2;
wire [4:0] writeReg;

wire [3:0] alu_ctrl;

wire [1:0] alu_op;

wire reg_dst, jump, branch, mem_to_reg, alu_src, reg_write, mux3_sel, zero, ctrl_mem_read, ctrl_mem_write;

assign add0_in1 = 32'd4; // Constant 4 for PC+4
assign jump_addr = {pc_plus_four[31:28], sl26_out[27:0]}; // Jump address contactentation
assign aluctrl_func_op = instr[5:0]; // ALU Control func input
assign mux3_sel =  branch & zero; // Set branch address when Branch,Zero == 1
assign readReg1 = instr[25-21];
assign readReg2 = instr[20-16];
assign inst_addr = pc_out;
assign data_in = readData2;
assign data_addr = alu_data_output;
assign writeReg = reg_dst_out;
assign opcode = instr[31:26];
assign sign_ext_in = instr[15:0];
assign sl26_in = instr[25:0];
assign reg_dst_input0 = instr[20:16];
assign reg_dst_input1 = instr[15:11];
//assign mem_read_ctrlsig = 

pc pc0(
	.in(pc_in), //32bit
	.clk,
	.rst(pc_reset),
	.en(pc_enable),
	.out(pc_out) //32bit
	);

// Moved control up here because mem_write from control feeds
// into mem_write for mem0
Control ctrl0(
	.clk,
	.opcode(opcode), //6bit
	.reg_dst(reg_dst),
	.jump(jump),
	.branch(branch),
	.ctrl_mem_read(mem_read_ctrlsig),
	.mem_to_reg(mem_to_reg),
	.ctrl_mem_write(mem_write_ctrlsig),
	.alu_src(alu_src),
	.reg_write(reg_write),
	.alu_op(alu_op) //2bit
	);

// 32-bit Adder for PC + 4
Adder_32b pc_adder(
	.clk,
	.input0(pc_out), //32bi
	.input1(add0_in1), //32bit
	.out(pc_plus_four) //32bit
	);

// 32-bit Adder for branch
Adder_32b adder1(
	.clk,
	.input0(pc_plus_four), //32bit
	.input1(sl32_out), //32bit
	.out(adder_result) //32bit
	);

reg_file registers(
    .clk,
	.regWrite(reg_write),
	.readReg1(readReg1), //5bit
	.readReg2(readReg2), //5bit
	.writeReg(writeReg), //5bit
	.writeData(mem_to_reg_out), //32bit
	.readData1(readData1), //32bit
	.readData2(readData2) //32bit
	);

sign_extender signext0(
	.clk,
	.in (sign_ext_in), //16bit
	.out (sign_ext_out) //32bit
	);

Shift_left2_26b sl26(
	.clk,
	.in (sl26_in), //26bit
	.out (sl26_out) //28bit
	);

Shift_left2_32b sl32(
	.clk,
	.in (sign_ext_out), //32bit
	.out (sl32_out) //32bit
	);

// THIS NEEDS TO BE 5 BIT MUX
Mux2x1_5b Mux_RegDst(
	.clk,
	.input0 (reg_dst_input0), //5bit
	.input1 (reg_dst_input1), //5bit
	.select (reg_dst),
	.out (reg_dst_out) //5bit
	);

Mux2x1_32b Mux_ALUsrc(
	.clk,
	.input0 (readData2), //32bit
	.input1 (sign_ext_out), //32bit
	.select (alu_src),
	.out (alu_src_out) //32bit
	);

Mux2x1_32b Mux_MemtoReg(
	.clk,
	.input0 (alu_data_output), //32bit
	.input1 (data_out), //32bit
	.select (mem_to_reg),
	.out (mem_to_reg_out) //32bit
	);

Mux2x1_32b Mux_Branch(
	.clk,
	.input0 (pc_plus_four), //32bit
	.input1 (adder_result), //32bit
	.select (mux3_sel),
	.out (branch_out) //32bit
	);

Mux2x1_32b Mux_Jump(
	.clk,
	.input0 (branch_out), //32bit
	.input1 (jump_addr), //32bit
	.select (jump),
	.out (pc_in) //32bit
	);

alu_control aluctrl(
	.clk,
	.alu_op, //2bit
	.func_op (aluctrl_func_op), //6bit
	.alu_control_sig (alu_ctrl) //4bit
	);

ALU alu0(
	.clk,
	.control (alu_ctrl), //4bit
	.data_input1 (readData1), //32bit
	.data_input2 (alu_src_out), //32bit
	.data_output (alu_data_output), //32bit
	.zero
	);

endmodule
