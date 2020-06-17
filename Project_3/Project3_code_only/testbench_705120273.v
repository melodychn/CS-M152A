`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:06:46 05/09/2020
// Design Name:   clock_gen
// Module Name:   /home/melody/152a/Project_3/testbench_705120273.v
// Project Name:  Project_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_gen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_705120273;

	// Inputs
	reg clk_in;
	reg rst;

	// Outputs
	wire clk_div_2;
	wire clk_div_4;
	wire clk_div_8;
	wire clk_div_16;
	wire clk_div_28;
	wire clk_div_5;
	wire [7:0] glitchy_counter;

	// Instantiate the Unit Under Test (UUT)
	clock_gen uut (
		.clk_in(clk_in), 
		.rst(rst), 
		.clk_div_2(clk_div_2), 
		.clk_div_4(clk_div_4), 
		.clk_div_8(clk_div_8), 
		.clk_div_16(clk_div_16), 
		.clk_div_28(clk_div_28), 
		.clk_div_5(clk_div_5), 
		.glitchy_counter(glitchy_counter)
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
		#10
		clk_in = 1;
		rst = 0;

	end
	always clk_in = #10 ~clk_in;
      
      
endmodule

