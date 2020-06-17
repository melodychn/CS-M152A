`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:15:10 05/23/2020 
// Design Name: 
// Module Name:    vending_machine 
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
module vending_machine(
    input CARD_IN,
    input VALID_TRAN,
    input [2:0] ITEM_CODE,
    input KEY_PRESS,
    input DOOR_OPEN,
    input RELOAD,
    input CLK,
    input RESET,
    output reg VEND,
    output reg INVALID_SEL,
    output reg FAILED_TRAN,
    output reg [2:0] COST
//	 output current_state
//	 output code1,
//	 output code2, 
//	 output count,
//	 output clk_start
//	 output code1inputted
//	 output SL13
    );
	 
	 parameter IDLE = 4'b0000;
	 parameter RELOAD_STATE = 4'b0001;
	 parameter CARD_INSERT_WAIT = 4'b0010;
	 parameter FIRST_DIGIT_INPUT = 4'b0011;
	 parameter SCND_DIGIT_INPUT = 4'b0100;
	 parameter INVALID_INPUT = 4'b0101;
	 parameter VALID_INPUT = 4'b0110;
	 parameter FAILED_TRAN_STATE = 4'b0111;
	 parameter VEND_STATE = 4'b1000;
	 parameter DOOR_OPEN_STATE = 4'b1001;
	 parameter RST = 4'b1010;
	 parameter WAIT = 4'b1011;
	 parameter CHECK_VALID = 4'b1100;
	 parameter WAIT_TRAN = 4'b1101;
	 parameter WAIT_VEND = 4'b1110;
	 
	 reg [3:0] current_state;
	 reg [3:0] next_state;
	 
	 reg [3:0] SL0;
	 reg [3:0] SL1;
	 reg [3:0] SL2;
	 reg [3:0] SL3;
	 reg [3:0] SL4;
	 reg [3:0] SL5;
	 reg [3:0] SL6;
	 reg [3:0] SL7;
	 reg [3:0] SL8;
	 reg [3:0] SL9;
	 reg [3:0] SL10;
	 reg [3:0] SL11;
	 reg [3:0] SL12;
	 reg [3:0] SL13;
	 reg [3:0] SL14;
	 reg [3:0] SL15;
	 reg [3:0] SL16;
	 reg [3:0] SL17;
	 reg [3:0] SL18;
	 reg [3:0] SL19;
	 
	 reg [2:0] count;
	 reg clk_start;
	 reg count_up;
	 
	 reg [3:0] code1;
	 reg [3:0] code2;
	 reg code1inputted;
	 
	 always@(posedge CLK)
	 begin
		if(RESET)
			current_state <= RST;
		else
			current_state <= next_state;
	 end
	 
	 always@(posedge CLK)
	 begin
		if((current_state == CARD_INSERT_WAIT || current_state == VALID_INPUT || current_state == VEND_STATE) 
			&& clk_start == 0)	
			clk_start <= 1;
		else
			clk_start <= 0;
	 end
	 
	 always @ (posedge CLK)
    begin
		if (clk_start)
			count <= 3'b000;
		else if(count_up)
			count <= count + 1'b1;
	 end

	 
	 always @ (posedge CLK)
	 begin
		if (current_state == RST)
		begin
			SL0 <= 0;
			SL1 <= 0;
			SL2 <= 0;
			SL3 <= 0;
			SL4 <= 0;
			SL5 <= 0;
			SL6 <= 0;
			SL7 <= 0;
			SL8 <= 0;
			SL9 <= 0;
			SL10 <= 0;
			SL11 <= 0;
			SL12 <= 0;
			SL13 <= 0;
			SL14 <= 0;
			SL15 <= 0;
			SL16 <= 0;
			SL17 <= 0;
			SL18 <= 0;
			SL19 <= 0;
		end
		else if (current_state == RELOAD_STATE)
		begin
			SL0 <= 10;
			SL1 <= 10;
			SL2 <= 10;
			SL3 <= 10;
			SL4 <= 10;
			SL5 <= 10;
			SL6 <= 10;
			SL7 <= 10;
			SL8 <= 10;
			SL9 <= 10;
			SL10 <= 10;
			SL11 <= 10;
			SL12 <= 10;
			SL13 <= 10;
			SL14 <= 10;
			SL15 <= 10;
			SL16 <= 10;
			SL17 <= 10;
			SL18 <= 10;
			SL19 <= 10;
		end
		else if(current_state == VEND_STATE)
		begin
					if(code1 == 0 && code2 == 0) SL0 <= SL0 - 1;
					else if(code1 == 0 && code2 == 1) SL1 <= SL1 - 1;
					else if(code1 == 0 && code2 == 2) SL2 <= SL2 - 1;
					else if(code1 == 0 && code2 == 3) SL3 <= SL3 - 1;
					else if(code1 == 0 && code2 == 4) SL4 <= SL4 - 1;
					else if(code1 == 0 && code2 == 5) SL5 <= SL5 - 1;
					else if(code1 == 0 && code2 == 6) SL6 <= SL6 - 1;
					else if(code1 == 0 && code2 == 7) SL7 <= SL7 - 1;
					else if(code1 == 0 && code2 == 8) SL8 <= SL8 - 1;
					else if(code1 == 0 && code2 == 9) SL9 <= SL9 - 1;
					else if(code1 == 1 && code2 == 0) SL10 <= SL10 - 1;
					else if(code1 == 1 && code2 == 1) SL11 <= SL11 - 1;
					else if(code1 == 1 && code2 == 2) SL12 <= SL12 - 1;
					else if(code1 == 1 && code2 == 3) SL13 <= SL13 - 1;
					else if(code1 == 1 && code2 == 4) SL14 <= SL14 - 1;
					else if(code1 == 1 && code2 == 5) SL15 <= SL15 - 1;
					else if(code1 == 1 && code2 == 6) SL16 <= SL16 - 1;
					else if(code1 == 1 && code2 == 7) SL17 <= SL17 - 1;
					else if(code1 == 1 && code2 == 8) SL18 <= SL18 - 1;
					else if(code1 == 1 && code2 == 9) SL19 <= SL19 - 1;
		end
	 end
	 
	 always @ (*) begin
		case(current_state)
			RST:
			begin
				next_state = IDLE;
				count_up = 0;
			end
			IDLE:
				begin
					code1inputted = 0;
					count_up = 0;
					if(RELOAD)
						next_state = RELOAD_STATE;
					else if(CARD_IN)
						next_state = CARD_INSERT_WAIT;
					else
						next_state = IDLE;
				end
			RELOAD_STATE:
				begin
					count_up = 0;
					next_state = IDLE;
				end
			CARD_INSERT_WAIT:
				begin
					if(KEY_PRESS && ~code1inputted)
					begin
						code1 = ITEM_CODE;
						code2 = code2;
						code1inputted = 1;
						count_up = 1;
						next_state = CARD_INSERT_WAIT;
					end
					else if(KEY_PRESS && code1inputted)
					begin 
						code2 = ITEM_CODE;
						code1 = code1;
						next_state = CHECK_VALID;
						count_up = 0;
					end
					else
					begin
						code1 = code1;
						code2 = code2;
						next_state = WAIT;
						count_up = 1;
					end
				end
			WAIT:
				begin 
					if(count == 2)
					begin
						next_state = INVALID_INPUT;
						count_up = 0;
					end
					else if(KEY_PRESS && code1inputted)
					begin
						code2 = ITEM_CODE;
						code1 = code1;
						next_state = CHECK_VALID;
						count_up = 0;
					end
					else if(KEY_PRESS && ~code1inputted)
					begin
						code1 = ITEM_CODE;
						code2 = 0;
						next_state = CARD_INSERT_WAIT;
						code1inputted = 1;
						count_up = 0;
					end
					else
					begin
						code1 = code1;
						code2 = code2;
						next_state = WAIT;
						count_up = 1;
					end
				end
			CHECK_VALID:
				begin
					count_up = 0;
					if((code1 == 1 || code1 == 0) && (code2 >= 0) && (code2 <= 9))
					begin
						if((code1 == 0 && code2 == 0 && SL0 > 0) ||
							(code1 == 0 && code2 == 1 && SL1 > 0) ||
							(code1 == 0 && code2 == 2 && SL2 > 0) ||
							(code1 == 0 && code2 == 3 && SL3 > 0) ||
							(code1 == 0 && code2 == 4 && SL4 > 0) ||
							(code1 == 0 && code2 == 5 && SL5 > 0) ||
							(code1 == 0 && code2 == 6 && SL6 > 0) ||
							(code1 == 0 && code2 == 7 && SL7 > 0) ||
							(code1 == 0 && code2 == 8 && SL8 > 0) ||
							(code1 == 0 && code2 == 9 && SL9 > 0) ||
							(code1 == 1 && code2 == 0 && SL10 > 0) ||
							(code1 == 1 && code2 == 1 && SL11 > 0) ||
							(code1 == 1 && code2 == 2 && SL12 > 0) ||
							(code1 == 1 && code2 == 3 && SL13 > 0) ||
							(code1 == 1 && code2 == 4 && SL14 > 0) ||
							(code1 == 1 && code2 == 5 && SL15 > 0) ||
							(code1 == 1 && code2 == 6 && SL16 > 0) ||
							(code1 == 1 && code2 == 7 && SL17 > 0) ||
							(code1 == 1 && code2 == 8 && SL18 > 0) ||
							(code1 == 1 && code2 == 9 && SL19 > 0))
							next_state = VALID_INPUT;
						else
							next_state = INVALID_INPUT;
					end
					else
						next_state = INVALID_INPUT;
				end
			INVALID_INPUT:
			begin
				next_state = IDLE;
				count_up = 0;
			end
			VALID_INPUT:
				begin
					if(VALID_TRAN)
					begin
						next_state = VEND_STATE;
						count_up = 0;
					end
					else
					begin
						next_state = WAIT_TRAN;
						count_up = 1;
					end
				end
			WAIT_TRAN:
				begin
					if(count == 2)
					begin
						next_state = FAILED_TRAN_STATE;
						count_up = 0;
					end
					else if(VALID_TRAN)
					begin
						next_state = VEND_STATE;
						count_up = 0;
					end
					else
					begin
						next_state = WAIT_TRAN;
						count_up = 1;
					end
				end
			FAILED_TRAN_STATE:
			begin
				next_state = IDLE;
				count_up = 0;
			end
			VEND_STATE:
				begin
					if(DOOR_OPEN)
					begin
						next_state = DOOR_OPEN_STATE;
						count_up = 0;
					end
					else
					begin
						next_state = WAIT_VEND;
						count_up = 1; 
					end
				end
			WAIT_VEND:
				begin
					if(count == 2)
					begin
						next_state = IDLE;
						count_up = 0;
					end
					else if(DOOR_OPEN)
					begin
						next_state = DOOR_OPEN_STATE;
						count_up = 0;
					end
					else
					begin
						next_state = WAIT_VEND;
						count_up = 1;
					end
				end
			DOOR_OPEN_STATE:
				begin
					count_up = 0;
					if(~DOOR_OPEN)
						next_state = IDLE;
					else
						next_state = DOOR_OPEN_STATE;
				end
			default: 
			begin
				next_state = IDLE;
				count_up = 0;
			end
		endcase	
	end
	
	always @(*) begin
		case(current_state)
			IDLE,
			CARD_INSERT_WAIT,
			FIRST_DIGIT_INPUT,
			SCND_DIGIT_INPUT,
			WAIT,
			CHECK_VALID:
				begin
					VEND = 0;
					INVALID_SEL = 0;
					COST = 3'b000;
					FAILED_TRAN = 0;
				end
			RST: 
				begin
					VEND = 0;
					INVALID_SEL = 0;
					COST = 3'b000;
					FAILED_TRAN = 0;
				end
			RELOAD:
				begin 
					VEND = 0;
					INVALID_SEL = 0;
					COST = 3'b000;
					FAILED_TRAN = 0;
				end
			INVALID_INPUT:
				begin
					VEND = 0;
					INVALID_SEL = 1;
					COST = 3'b000;
					FAILED_TRAN = 0;
				end
			VALID_INPUT:
				begin
					if((code1 == 0) && (code2 >= 0) && (code2 <= 3))
						COST = 1;
					else if((code1 == 0) && (code2 >= 4) && (code2 <= 7))
						COST = 2;
					else if(((code1 == 0) && (code2 >= 8) && (code2 <= 9))
								|| ((code1 == 1) && (code2 >= 0) && (code2 <= 1)))
						COST = 3;
					else if((code1 == 1) && (code2 >= 2) && (code2 <= 5))
						COST = 4;
					else if((code1 == 1) && (code2 >= 6) && (code2 <= 7))
						COST = 5;
					else if((code1 == 1) && (code2 >= 8) && (code2 <= 9))
						COST = 6;
				end
			FAILED_TRAN_STATE:
				FAILED_TRAN = 1;
			VEND_STATE:
				begin
					VEND = 1;
				end
		endcase
	end  
			
endmodule

