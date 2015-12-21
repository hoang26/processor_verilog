`timescale 1ns/100ps
module processor_tb;

reg clk;
reg pc_reset;
reg pc_enable;
//reg regInit;

// Making these wires instead of registers resolves:
// "illegal output or inout port connection for port"
wire [31:0] instr;
wire [31:0] data_out;
wire [31:0] data_in;
wire [31:0] inst_addr;
wire [31:0] data_addr;
wire mem_read_ctrlsig;
wire mem_write_ctrlsig;

processor DUT(
	.clk,
	.pc_reset,
	.pc_enable,
	.instr,
	.data_out,
	.data_in,
	.inst_addr,
	.data_addr,
	.mem_read_ctrlsig,
	.mem_write_ctrlsig
	);


Memory mem(
	.inst_addr,
	.instr,
	.data_addr,
	.data_in,
	.mem_read (mem_read_ctrlsig),
	.mem_write (mem_write_ctrlsig),
	.data_out
	);

// Initial Conditions
initial begin
    clk=0;
    pc_reset=0;
    pc_enable=1;
	//regInit=1;
end

// Clock
always #5 clk=~clk;


// Input Waveform

initial begin
#50
pc_reset=1;
#50
pc_reset=0;

//if (instr == 32'hfc000000) begin
//    $finish;
end

endmodule
