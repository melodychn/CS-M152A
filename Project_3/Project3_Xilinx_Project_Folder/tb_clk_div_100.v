`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:47:22 05/09/2020
// Design Name:   clock_div_hundred
// Module Name:   /home/melody/152a/Project_3/tb_clk_div_100.v
// Project Name:  Project_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_div_hundred
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_clk_div_100;

	// Inputs
	reg clk_in;
	reg rst;

	// Outputs
	wire clk_div_200;

	// Instantiate the Unit Under Test (UUT)
	clock_div_hundred uut (
		.clk_in(clk_in), 
		.rst(rst), 
		.clk_div_200(clk_div_200)
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
		#20 
		clk_in = 0;
		#20
		clk_in = 1;
		rst = 0;

	end
	always clk_in = #5 ~clk_in;
      
endmodule

