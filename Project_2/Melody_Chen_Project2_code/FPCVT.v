`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:15:14 05/03/2020 
// Design Name: 
// Module Name:    FPCVT 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module convertToSignMagnitude(
	 input [12:0] linear_encoding,
	 output reg [0:0] sign,
	 output reg [12:0] sign_magnitude
 );
		always @(linear_encoding) begin
			sign = linear_encoding[12];
			if(linear_encoding == 13'b1000000000000)
				sign_magnitude = 13'b0111111111111;
			else if(linear_encoding[12] == 1)
				sign_magnitude = ~(linear_encoding)+1;
			else
				sign_magnitude = linear_encoding;
		end
endmodule

module countLeadingZeroExtractBits(
    input [12:0] signMagnitude,
    output reg [2:0] exponent,
    output reg [4:0] significand,
    output reg [0:0] sixth_bit
);
	always @(*) begin
		if (signMagnitude[11] == 1) 
		begin
			exponent = 7;
			significand = signMagnitude[11:7];
			sixth_bit = signMagnitude[6];
		end
		else if (signMagnitude[10] == 1)
		begin
			exponent = 6;
			significand = signMagnitude[10:6];
			sixth_bit = signMagnitude[5];
		end
		else if (signMagnitude[9] == 1)
		begin
			exponent = 5;
			significand = signMagnitude[9:5];
			sixth_bit = signMagnitude[4];
		end
		else if (signMagnitude[8] == 1)
		begin
			exponent = 4;
			significand = signMagnitude[8:4];
			sixth_bit = signMagnitude[3];
		end
		else if (signMagnitude[7] == 1)
		begin
			exponent = 3;
			significand = signMagnitude[7:3];
			sixth_bit = signMagnitude[2];
		end
		else if (signMagnitude[6] == 1)
		begin
			exponent = 2;
			significand = signMagnitude[6:2];
			sixth_bit = signMagnitude[1];
		end
		else if (signMagnitude[5] == 1)
		begin
			exponent = 1;
			significand = signMagnitude[5:1];
			sixth_bit = signMagnitude[0];
		end
		else
		begin
			exponent = 0;
			significand = signMagnitude[4:0];
			sixth_bit = 0;
		end
	end
endmodule

module round(
    input [2:0] exponent,
    input [4:0] significand,
    input [0:0] sixth_bit,
    output reg [2:0] E,
    output reg [4:0] F
    );
	always @(*) begin
		if (sixth_bit == 1)
		begin
			if(significand != 5'b11111) // no overflow in significand
			begin
				E = exponent;
				F = significand + 1;
			end
			else // overflow
			begin 
				if(exponent != 3'b111) // no overflow in exp
				begin
					E = exponent + 1;
					F = (significand >> 1) + 1;
				end
				else
				begin
					E = 3'b111;
					F = 5'b11111;
				end
			end
		end
		else
		begin
			E = exponent;
			F = significand;
		end
	end
endmodule

module FPCVT(
    input [12:0] D,
    output S,
    output [2:0] E,
    output [4:0] F
    );
// Outputs
wire [12:0] sign_magnitude;
wire sign; 

assign S = sign;

convertToSignMagnitude mod1 (
	.linear_encoding(D), 
	.sign(sign), 
	.sign_magnitude(sign_magnitude)
);

// Outputs
wire [2:0] exponent;
wire [4:0] significand;
wire [0:0] sixth_bit;

// Instantiate the Unit Under Test (UUT)
countLeadingZeroExtractBits mod2 (
	.signMagnitude(sign_magnitude), 
	.exponent(exponent), 
	.significand(significand), 
	.sixth_bit(sixth_bit)
);

wire [2:0] e_output;
wire [4:0] f_output;

// Instantiate the Unit Under Test (UUT)
round mod3 (
	.exponent(exponent), 
	.significand(significand), 
	.sixth_bit(sixth_bit), 
	.E(e_output), 
	.F(f_output)
);

assign E = e_output;
assign F = f_output;

endmodule
