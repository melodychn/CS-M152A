`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:12:05 06/06/2020 
// Design Name: 
// Module Name:    parking_meter 
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
module parking_meter(
    input add1,
    input add2,
    input add3,
    input add4,
    input rst1,
    input rst2,
    input clk,
    input rst,
//	 output reg [13:0] time_left,
//	 output reg [6:0] count_main,
//	 output reg [3:0] current_state,
    output reg [6:0] led_seg,
    output reg a1,
    output reg a2,
    output reg a3,
    output reg a4,
	 output [3:0] val1,
	 output [3:0] val2,
	 output [3:0] val3,
	 output [3:0] val4
    );
	 
	 parameter INITIAL = 4'b0000;
	 parameter ADD60 = 4'b0001;
	 parameter ADD120 = 4'b0010;
	 parameter ADD180 = 4'b0011;
	 parameter ADD300 = 4'b0100;
	 parameter FLASH_SLOW = 4'b0101;
	 parameter INITIAL16 = 4'b0111;
	 parameter INITIAL150 = 4'b1000;
	 parameter CHECK = 4'b1001;
	 parameter ZERO = 4'b1010;
	 
	 reg[3:0] current_state;
	 reg[3:0] next_state;
//	 
	 reg[13:0] time_left;
	 
	 
	 // for counting down at 1Hz given 100Hz input clk signal
	 localparam constNumber = 101;
	 reg [6:0] count_main;
	 reg [5:0] count_flash;

	 always @ (posedge clk) 
		begin
		  if (rst || current_state == INITIAL16 || current_state == INITIAL150)
			 count_main <= 7'b0000001;
		  else if (current_state == INITIAL)
		    count_main <= 0;
		  else if (count_main == (constNumber - 1))
			 count_main <= 7'b0000001;
		  else 
			 count_main <= count_main + 1'b1;
		end
	 
	 reg flash;
	 always@(posedge clk)
	 begin
		if(rst || current_state == ZERO)
			count_flash <= 0;
		else if(count_flash == 49)
			count_flash <= 0;
		else
			count_flash <= count_flash + 1'b1;
	 end
	 
	 always@(posedge clk)
	 begin
		if(rst)
			flash <= 1'b1;
		else if(count_flash == 49)
			flash <= ~(flash);
		else
			flash <= flash;
	 end
	 
	 always@(posedge clk)
	 begin
		if(rst)
			current_state <= INITIAL;
		else if(rst1)
			current_state <= INITIAL16;
		else if(rst2)
			current_state <= INITIAL150;
		else
			current_state <= next_state;
	 end
	 
	 always@(*) begin
		case(current_state)
			INITIAL:
			begin
				if(add1)
					next_state = ADD60;
				else if(add2)
					next_state = ADD120;
				else if(add3)
					next_state = ADD180;
				else if(add4)
					next_state = ADD300;
				else
					next_state = INITIAL;
			end
			INITIAL16,
			INITIAL150:
			begin
				if(add1)
					next_state = ADD60;
				else if(add2)
					next_state = ADD120;
				else if(add3)
					next_state = ADD180;
				else if(add4)
					next_state = ADD300;
				else
					next_state = CHECK;
			end
			ADD60,
			ADD120,
			ADD180,
			ADD300:
			begin
				next_state = CHECK;
			end
			CHECK:
			begin
				if(add1)
					next_state = ADD60;
				else if(add2)
					next_state = ADD120;
				else if(add3)
					next_state = ADD180;
				else if(add4)
					next_state = ADD300;
				else if(time_left < 180)
					next_state = FLASH_SLOW;
				else
					next_state = CHECK;
			end
			FLASH_SLOW:
			begin
				if(add1)
					next_state = ADD60;
				else if(add2)
					next_state = ADD120;
				else if(add3)
					next_state = ADD180;
				else if(add4)
					next_state = ADD300;
				else if(time_left == 0)
				begin
					next_state = ZERO;
				end
				else
					next_state = FLASH_SLOW;
			end
			ZERO:
			begin
				if(add1)
					next_state = ADD60;
				else if(add2)
					next_state = ADD120;
				else if(add3)
					next_state = ADD180;
				else if(add4)
					next_state = ADD300;
				else
					next_state = INITIAL;
			end
			default:
				next_state = current_state;
		endcase
	end
	
	always@(posedge clk) begin
		case(current_state)
			ZERO,
			INITIAL:
				time_left <= 0;
			INITIAL16:
			begin
				if(count_main == (constNumber - 1))
					time_left <= 15;
				else
					time_left <= 16;
			end
			INITIAL150:
			begin
				if(count_main == (constNumber - 1))
					time_left <= 149;
				else
					time_left <= 150;
			end
			ADD60:
			begin
				if(count_main == (constNumber - 1))
					time_left <= ((time_left + 59) > 9999)?9999:(time_left + 59);
				else
					time_left <= ((time_left + 60) > 9999)?9999:(time_left + 60);
			end
			ADD120:
			begin
				if(count_main == (constNumber - 1))
					time_left <= ((time_left + 119) > 9999)?9999:(time_left + 119);
				else
					time_left <= ((time_left + 120) > 9999)?9999:(time_left + 120);
			end
			ADD180:
			begin
				if(count_main == (constNumber - 1))
					time_left <= ((time_left + 179) > 9999)?9999:(time_left + 179);
				else
					time_left <= ((time_left + 180) > 9999)?9999:(time_left + 180);
			end
			ADD300:
			begin
				if(count_main == (constNumber - 1))
					time_left <= ((time_left + 299) > 9999)?9999:(time_left + 299);
				else
					time_left <= ((time_left + 300) > 9999)?9999:(time_left + 300);
			end
			CHECK,
			FLASH_SLOW:
			begin
				if(count_main == (constNumber - 1))
					time_left <= time_left - 1;
				else
					time_left <= time_left;
			end
		endcase
	end
	
	reg [6:0] led_seg0;
	reg [6:0] led_seg1;
	reg [6:0] led_seg2;
	reg [6:0] led_seg3;
	
	assign val4 = time_left % 10;
	assign val3 = (time_left/10) % 10;
	assign val2 = (time_left/100) % 10;
	assign val1 = (time_left/1000) % 10;
	
	// combination logic for calculating led_seg0 output
	always@(*)
	begin
		if((time_left % 10) == 0)
			led_seg0 = 7'b0000001;
		else if((time_left % 10) == 1)
			led_seg0 = 7'b1001111;
		else if((time_left % 10) == 2)
			led_seg0 = 7'b0010010;
		else if((time_left % 10) == 3)
			led_seg0 = 7'b0000110;
		else if((time_left % 10) == 4)
			led_seg0 = 7'b1001100;
		else if((time_left % 10) == 5)
			led_seg0 = 7'b0100100;
		else if((time_left % 10) == 6)
			led_seg0 = 7'b0100000;
		else if((time_left % 10) == 7)
			led_seg0 = 7'b0001111;
		else if((time_left % 10) == 8)
			led_seg0 = 7'b0000000;
		else if((time_left % 10) == 9)
			led_seg0 = 7'b0000100;
		else
			led_seg0 = 7'b0000001;
	end
	
	always@(*)
	begin
		if(((time_left/10) % 10) == 0)
			led_seg1 = 7'b0000001;
		else if(((time_left/10) % 10) == 1)
			led_seg1 = 7'b1001111;
		else if(((time_left/10) % 10) == 2)
			led_seg1 = 7'b0010010;
		else if(((time_left/10) % 10) == 3)
			led_seg1 = 7'b0000110;
		else if(((time_left/10) % 10) == 4)
			led_seg1 = 7'b1001100;
		else if(((time_left/10) % 10) == 5)
			led_seg1 = 7'b0100100;
		else if(((time_left/10) % 10) == 6)
			led_seg1 = 7'b0100000;
		else if(((time_left/10) % 10) == 7)
			led_seg1 = 7'b0001111;
		else if(((time_left/10) % 10) == 8)
			led_seg1 = 7'b0000000;
		else if(((time_left/10) % 10) == 9)
			led_seg1 = 7'b0000100;
		else
			led_seg1 = 7'b0000001;
	end
	
	always@(*)
	begin
		if(((time_left/100) % 10) == 0)
			led_seg2 = 7'b0000001;
		else if(((time_left/100) % 10) == 1)
			led_seg2 = 7'b1001111;
		else if(((time_left/100) % 10) == 2)
			led_seg2 = 7'b0010010;
		else if(((time_left/100) % 10) == 3)
			led_seg2 = 7'b0000110;
		else if(((time_left/100) % 10) == 4)
			led_seg2 = 7'b1001100;
		else if(((time_left/100) % 10) == 5)
			led_seg2 = 7'b0100100;
		else if(((time_left/100) % 10) == 6)
			led_seg2 = 7'b0100000;
		else if(((time_left/100) % 10) == 7)
			led_seg2 = 7'b0001111;
		else if(((time_left/100) % 10) == 8)
			led_seg2 = 7'b0000000;
		else if(((time_left/100) % 10) == 9)
			led_seg2 = 7'b0000100;
		else
			led_seg2 = 7'b0000001;
	end
	
	always@(*)
	begin
		if(((time_left/1000) % 10) == 0)
			led_seg3 = 7'b0000001;
		else if(((time_left/1000) % 10) == 1)
			led_seg3 = 7'b1001111;
		else if(((time_left/1000) % 10) == 2)
			led_seg3 = 7'b0010010;
		else if(((time_left/1000) % 10) == 3)
			led_seg3 = 7'b0000110;
		else if(((time_left/1000) % 10) == 4)
			led_seg3 = 7'b1001100;
		else if(((time_left/1000) % 10) == 5)
			led_seg3 = 7'b0100100;
		else if(((time_left/1000) % 10) == 6)
			led_seg3 = 7'b0100000;
		else if(((time_left/1000) % 10) == 7)
			led_seg3 = 7'b0001111;
		else if(((time_left/1000) % 10) == 8)
			led_seg3 = 7'b0000000;
		else if(((time_left/1000) % 10) == 9)
			led_seg3 = 7'b0000100;
		else
			led_seg3 = 7'b0000001;
	end
	
	reg [3:0] index;
	always@(posedge clk)
	begin
		if(rst)
			index <= 4'b0001;
		else
			index <= {index[2:0], index[3]};
	end
	
	always@(posedge clk)
	begin
		if(time_left == 0)
		begin
			if(flash == 1)
			begin
				if(index[3])
				begin
					a1 <= 1;
					a2 <= 1;
					a3 <= 1;
					a4 <= 0;
					led_seg <= led_seg0;
				end
				else if(index[2])
				begin
					a1 <= 1;
					a2 <= 1;
					a3 <= 0;
					a4 <= 1;
					led_seg <= led_seg1;
				end
				else if(index[1])
				begin
					a1 <= 1;
					a2 <= 0;
					a3 <= 1;
					a4 <= 1;
					led_seg <= led_seg2;
				end
				else if(index[0])
				begin
					a1 <= 0;
					a2 <= 1;
					a3 <= 1;
					a4 <= 1;
					led_seg <= led_seg3;
				end
			end
			else
			begin
				a1 <= 1;
				a2 <= 1;
				a3 <= 1;
				a4 <= 1;
			end
		end
		else if(time_left >= 180)
		begin
			if(index[3])
			begin
				a1 <= 1;
				a2 <= 1;
				a3 <= 1;
				a4 <= 0;
				led_seg <= led_seg0;
			end
			else if(index[2])
			begin
				a1 <= 1;
				a2 <= 1;
				a3 <= 0;
				a4 <= 1;
				led_seg <= led_seg1;
			end
			else if(index[1])
			begin
				a1 <= 1;
				a2 <= 0;
				a3 <= 1;
				a4 <= 1;
				led_seg <= led_seg2;
			end
			else if(index[0])
			begin
				a1 <= 0;
				a2 <= 1;
				a3 <= 1;
				a4 <= 1;
				led_seg <= led_seg3;
			end
		end
		else
		begin
			if((time_left % 2) == 0)
			begin
				if(index[3])
				begin
					a1 <= 1;
					a2 <= 1;
					a3 <= 1;
					a4 <= 0;
					led_seg <= led_seg0;
				end
				else if(index[2])
				begin
					a1 <= 1;
					a2 <= 1;
					a3 <= 0;
					a4 <= 1;
					led_seg <= led_seg1;
				end
				else if(index[1])
				begin
					a1 <= 1;
					a2 <= 0;
					a3 <= 1;
					a4 <= 1;
					led_seg <= led_seg2;
				end
				else if(index[0])
				begin
					a1 <= 0;
					a2 <= 1;
					a3 <= 1;
					a4 <= 1;
					led_seg <= led_seg3;
				end
			end
			else
			begin
				a1 <= 1;
				a2 <= 1;
				a3 <= 1;
				a4 <= 1;
			end
		end
	end

endmodule
