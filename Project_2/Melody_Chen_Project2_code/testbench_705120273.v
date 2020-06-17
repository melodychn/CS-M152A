`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:04:10 05/03/2020
// Design Name:   FPCVT
// Module Name:   /home/melody/152a/Project_2_combined/tb_FPCVT.v
// Project Name:  Project_2_combined
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FPCVT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_705120273;

	// Inputs
	reg [12:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [4:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;
      D = 13'b1111001011010;	// normal negative number	
		// Add stimulus here
		#100;
		D = 13'b0000110100110;	// normal
		
		#100;
		D = 13'b1111111111111; // all 1's
		
		#100;
		D = 13'b0111111111111;	// largest positive number, significand and exp overflows
		
		#100;
		D = 13'b0001011000111; // normal
		
		#100;
		D = 13'b1000000000000; // signed magnitude overflows
		
		#100;
		D = 13'b0001011010111; // significand rounds
		
		#100;
		D = 13'b0001111110111; // significand overflows

	end
      
endmodule

