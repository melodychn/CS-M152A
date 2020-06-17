`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:49:00 05/08/2020
// Design Name:   clock_div_thirty_three
// Module Name:   /home/melody/152a/Project_3/tb_clock_div_33.v
// Project Name:  Project_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_div_thirty_three
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_clock_div_33;

	// Inputs
	reg clk_in;
	reg rst;

	// Outputs
	wire clk_div_33;
	wire clk_div_33_neg;
	wire clk_div_33_or;
	// Instantiate the Unit Under Test (UUT)
	clock_div_thirty_three uut (
		.clk_in(clk_in), 
		.rst(rst), 
		.clk_div_33(clk_div_33),
		.clk_div_33_or(clk_div_33_or),
		.clk_div_33_neg(clk_div_33_neg)
	);


	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 0;
		// Wait 100 ns for global reset to finish
		#100;
 		clk_in = 1;
		rst = 1;
		// Add stimulus here
		#100 
		clk_in = 0;
		#100
		clk_in = 1;
		rst = 0;

	end
	always clk_in = #100 ~clk_in;
      
endmodule

