module ALU(clk, control, data_input1, data_input2, data_output, zero);

input wire clk;
input wire [3:0] control;
input wire signed [31:0] data_input1, data_input2;

output reg signed [31:0] data_output;
output reg zero;

// Control signal definitions, taken from page 260
// High zero to indicate when output is zero (beq and sub)

always@(posedge clk)

begin
    // Load word and store word
    if (control == 4'b0010) begin
        data_output <= data_input1 + data_input2;
        zero <= 0;
    end

    // Branch equal
    else if (control == 4'b0110) begin
        data_output = data_input1 - data_input2;
        if (data_output == 0)
	    zero <= 1;
	else
	    zero <= 0;
    end

    // R-type Add
    else if (control == 4'b0010) begin
        data_output <= data_input1 + data_input2;
        zero <= 0;
    end

    // R-type Subtract
    else if (control == 4'b0110) begin
        data_output = data_input1 - data_input2;
	if (data_output == 0)
	    zero <= 1;
	else
	    zero <= 0;
    end

    // And
    else if (control == 4'b0000) begin
        data_output <= data_input1 & data_input2;
        zero <= 0;
    end

    // Or
    else if (control == 4'b0001) begin
	data_output <= data_input1 | data_input2;
	zero <= 0;
    end

    // Set less than
    else if (control == 4'b0111) begin
        if (data_input2 < data_input1)
            data_output <= 1;
        else
            data_output <= 0;
        zero <= 0;
    end

end


endmodule

