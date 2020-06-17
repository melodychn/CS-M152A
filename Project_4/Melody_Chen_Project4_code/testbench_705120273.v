`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:47:15 05/23/2020
// Design Name:   vending_machine
// Module Name:   /home/melody/152a/Project_4/testbench_705120273.v
// Project Name:  Project_4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vending_machine
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
	reg CARD_IN;
	reg VALID_TRAN;
	reg [2:0] ITEM_CODE;
	reg KEY_PRESS;
	reg DOOR_OPEN;
	reg RELOAD;
	reg clk;
	reg RESET;

	// Outputs
	wire VEND;
	wire INVALID_SEL;
	wire FAILED_TRAN;
	wire [2:0] COST;
//	wire [3:0] current_state;
//	wire [2:0] code1;
//	wire [2:0] code2;
//	wire [2:0] count;
//	wire clk_start;
//	wire code1inputted;
//	wire [3:0] SL13;

	// Instantiate the Unit Under Test (UUT)
	vending_machine uut (
		.CARD_IN(CARD_IN), 
		.VALID_TRAN(VALID_TRAN), 
		.ITEM_CODE(ITEM_CODE), 
		.KEY_PRESS(KEY_PRESS), 
		.DOOR_OPEN(DOOR_OPEN), 
		.RELOAD(RELOAD), 
		.CLK(clk), 
		.RESET(RESET), 
		.VEND(VEND), 
		.INVALID_SEL(INVALID_SEL), 
		.FAILED_TRAN(FAILED_TRAN), 
		.COST(COST)
//		.current_state(current_state)
//		.code1(code1),
//		.code2(code2),
//		.count(count),
//		.clk_start(clk_start)
//		.code1inputted(code1inputted),
//		.SL13(SL13)
	);

	initial begin
		// Initialize Inputs
		CARD_IN = 0;
		VALID_TRAN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		DOOR_OPEN = 0;
		RELOAD = 0;
		clk = 0;
		RESET = 0;
		// SUCCESSFUL TRY
		#10;
      clk = 0;
		RESET = 0;
		#10
		clk = 1;
		RESET = 1; // initialize with reset
		#10
		clk = 0;	
		#10
		clk = 1;
		RESET = 0;
		#10
		clk = 0;	
		#10
		clk = 1;
		#10
		clk = 0;
		RELOAD = 1; // reload machine
		#10
		clk = 1;
		#10
		clk = 0;
		RELOAD = 0; // stop reload
		#10
		clk = 1;
		#10
		clk = 0;
		CARD_IN = 1; // card is inserted
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1; // key pressed and first code entered
		ITEM_CODE = 1;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0; // key no longer pressed
		#10 
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1; // key pressed and second code entered
		ITEM_CODE = 3;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		VALID_TRAN = 1; // transaction is valid signal 
		#10
		clk = 1;
		#10
		clk = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 1; // door of vending machine opens
		#10
		clk = 1;
		#10
		clk = 0;
		DOOR_OPEN = 0; // door closes
		#10
		clk = 1;
		#10
		clk = 0;
		CARD_IN = 0; // card is taken out
		#10
		clk = 1;
		#10
		clk = 0;
		#10 // back to idle state
		clk = 1;
		// FAILED TRY, card inputted but no key press for five seconds
		#10
		clk = 0;
		CARD_IN = 1; 
		#10
		clk = 1; // 1
		#10
		clk = 0;
		#10
		clk = 1; // 2
		#10
		clk = 0;
		CARD_IN = 0;
		#10
		clk = 1; // 3
		#10
		clk = 0;
		#10
		clk = 1; // 4
		#10
		clk = 0;
		#10
		clk = 1; // 5
		#10
		clk = 0;
		#10
		clk = 1; // 6
		#10
		clk = 0;
		#10
		clk = 1; // 7
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		// FAILED TRY, card inputted but only one key press
		#10
		clk = 0;
		CARD_IN = 1; 
		#10
		clk = 1; 
		#10
		clk = 0;
		#10
		clk = 1; 
		#10
		clk = 0;
		KEY_PRESS = 1; // key pressed and first code entered
		ITEM_CODE = 1;
		#10
		clk = 1; // 3
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1; // 4
		#10
		clk = 0;
		#10
		clk = 1; // 5
		#10
		clk = 0;
		#10
		clk = 1; // 6
		#10
		clk = 0;
		#10
		clk = 1; // 7
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		CARD_IN = 0;
		#10
		clk = 1;
		#10 
		// FAILED TRY, invalid numbers inputted
		clk = 0;
		CARD_IN = 1;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 2;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 7;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		CARD_IN = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		// FAILED TRY, WAITING FOR TRANSACTION SIGNAL
		CARD_IN = 1;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 7;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		CARD_IN = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		// FAILED TRY, DOOR DOES NOT OPEN ON TIME
		CARD_IN = 1;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 2;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		VALID_TRAN = 1;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		VALID_TRAN = 0;
		CARD_IN = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		RESET = 1;
		// when machine empty, no item left 
		// apply other signal in middle of something
		#10
		clk = 1;
		#10
		clk = 0;
		RESET = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		CARD_IN = 1;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 1;
		CARD_IN = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 1;
		ITEM_CODE = 3;
		#10
		clk = 1;
		#10
		clk = 0;
		KEY_PRESS = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
	end
      
endmodule
