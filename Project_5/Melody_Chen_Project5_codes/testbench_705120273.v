`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:54 06/06/2020
// Design Name:   parking_meter
// Module Name:   /home/melody/152a/Project_5/testbench_705120273.v
// Project Name:  Project_5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: parking_meter
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
	reg add1;
	reg add2;
	reg add3;
	reg add4;
	reg rst1;
	reg rst2;
	reg clk;
	reg rst;

	// Outputs
//	wire [13:0] time_left;
//	wire [6:0] count_main;
//	wire [3:0] current_state;
	wire [6:0] led_seg;
//	wire [5:0] count_flash;
   wire a1;
   wire a2;
   wire a3;
   wire a4;
	wire [3:0] val1;
	wire [3:0] val2;
	wire [3:0] val3;
	wire [3:0] val4;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	parking_meter uut (
		.add1(add1), 
		.add2(add2), 
		.add3(add3), 
		.add4(add4), 
		.rst1(rst1), 
		.rst2(rst2), 
		.clk(clk), 
		.rst(rst), 
//		.time_left(time_left),
//		.count_main(count_main),
//		.current_state(current_state),
		.led_seg(led_seg),
		.a1(a1),
		.a2(a2),
		.a3(a3),
		.a4(a4),
//		.count_flash(count_flash),
		.val1(val1),
		.val2(val2),
		.val3(val3),
		.val4(val4)
	);

	initial begin
		// Initialize Inputs
		add1 = 0;
		add2 = 0;
		add3 = 0;
		add4 = 0;
		rst1 = 0;
		rst2 = 0;
		clk = 0;
		rst = 0;
		
		// Set reset to high
		clk = 0;
		rst = 0;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		rst = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		rst = 0;	

		for(i = 0; i < 190; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ===================== case for addin 60 seconds =================
		// Add 60 seconds
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		add1 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		add1 = 0;
		#5000000
		clk = 0;
		
		// Want it to count to 67 seconds
		for(i = 0; i < 650; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ==================================================================
		
		// ==================== case for adding 120 seconds =================
		// Add 120 seconds
		clk = 0;
		#5000000
		clk = 1;
		add2 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		add2 = 0;
		#5000000
		clk = 0;
		
		// Continue counting down for few more seconds
		for(i = 0; i < 650; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		
		// ==================================================================
		// ==================== case for adding 180 seconds =================
		// Add 180 seconds
		clk = 0;
		#5000000
		clk = 1;
		add3 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		add3 = 0;
		#5000000
		clk = 0;
		
		// Continue counting down for few more seconds
		for(i = 0; i < 650; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ==================================================================
		// ==================== case for adding 300 seconds =================
		// Add 300 seconds
		clk = 0;
		#5000000
		clk = 1;
		add4 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		add4 = 0;
		#5000000
		clk = 0;
		
		// Continue counting down for few more seconds
		for(i = 0; i < 650; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ==================================================================
		
		// ===================== case for reset1 in the middle of operation ====
		clk = 0;
		#5000000
		clk = 1;
		rst1 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		rst1 = 0;
		#5000000
		clk = 0;
		
		// Continue counting down for few more seconds
		for(i = 0; i < 194; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ===================================================================
		
		// ===== case for adding right as time is decrementing to odd ========
		clk = 0;
		#5000000
		clk = 1;
		add1 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		add1 = 0;
		#5000000
		clk = 0;
		for(i = 0; i < 384; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ===================================================================
		
		// ===== case for reset2 in the middle of operation ==================
		clk = 0;
		#5000000
		clk = 1;
		rst2 = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		rst2 = 0;
		#5000000
		clk = 0;
		for(i = 0; i < 500; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ===================================================================
		
		// ===== case for reset2 in the middle of operation ==================
		clk = 0;
		#5000000
		clk = 1;
		rst = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		rst = 0;
		#5000000
		clk = 0;
		for(i = 0; i < 496; i = i + 1) begin
			clk = #5000000 ~clk; 
		end
		// ===================================================================
		// ===== case for adding until 9999 ==================================
		clk = 0;
		#5000000
		clk = 1;
		#5000000
		clk = 0;
		#5000000
		clk = 1;
		for(i = 0; i < 37; i = i + 1) begin
			#5000000
			clk = 0;
			#5000000
			clk = 1;
			add4 = 1;
			#5000000
			clk = 0;
			#5000000
			clk = 1;
			add4 = 0;
			#5000000
			clk = 0;
			#5000000
			clk = 1;
			#5000000
			clk = 0;
			#5000000
			clk = 1;
			#5000000
			clk = 0;
			#5000000
			clk = 1;
		end
	

	end

      
endmodule

