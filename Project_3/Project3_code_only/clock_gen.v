`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:33:46 05/09/2020 
// Design Name: 
// Module Name:    clock_gen 
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
module clock_gen(
    input clk_in,
    input rst,
    output clk_div_2,
    output clk_div_4,
    output clk_div_8,
    output clk_div_16,
    output clk_div_28,
    output clk_div_5,
    output [7:0] glitchy_counter
   );
	
clock_div_two task_one(
    .clk_in(clk_in),
    .rst(rst),
    .clk_div_2(clk_div_2),
    .clk_div_4(clk_div_4),
    .clk_div_8(clk_div_8),
    .clk_div_16(clk_div_16)
);

clock_div_twenty_eight task_two(
    .clk_in(clk_in),
    .rst(rst),
	 .clk_div_28(clk_div_28)
);

clock_div_five task_three(
    .clk_in(clk_in),
    .rst(rst),
	 .clk_div_5(clk_div_5)
);

clock_strobe task_four(
    .clk_in(clk_in),
    .rst(rst),
	 .glitchy_counter(glitchy_counter)
);

endmodule

module clock_div_two(
    input clk_in,
    input rst,
    output clk_div_2,
    output clk_div_4,
    output clk_div_8,
    output clk_div_16
    );
reg [3:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
		Q <= 4'b0000;
	else
		Q <= Q + 1'b1;
end
assign clk_div_2 = Q[0];
assign clk_div_4 = Q[1];
assign clk_div_8 = Q[2];
assign clk_div_16 = Q[3];
endmodule

module clock_div_twenty_eight(
    input clk_in,
    input rst,
    output reg clk_div_28
    );
reg [3:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
	begin
		Q <= 4'b0000;
		clk_div_28 <= 0;
	end
	else if (Q == 4'b1101)
	begin
		clk_div_28 <= ~clk_div_28;
		Q <= 4'b0000;
	end
	else
	begin
		Q <= Q + 1'b1;
	end
end

endmodule

module clock_div_five(
    input clk_in,
    input rst,
    output clk_div_5
    );
reg [4:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
	begin
		Q <= 5'b00110;
	end
	else
		Q <= {Q[3:0],Q[4]};
end
//assign clk_div_33 = Q[2];
reg [4:0] Q_neg;
always @ (negedge clk_in)
begin
	if (rst)
	begin
		Q_neg <= 5'b00110;
	end
	else
		Q_neg <= {Q_neg[3:0],Q_neg[4]};
end
//assign clk_div_33_neg = Q_neg[3];
assign clk_div_5 = Q[4] || Q_neg[4];

endmodule

module clock_strobe(
    input clk_in,
    input rst,
    output reg [7:0] glitchy_counter
    );
	 
reg [3:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
	begin
		Q <= 4'b0001;
	end
	else
	begin
		Q <= {Q[2:0],Q[3]};
	end
end

always @ (posedge clk_in)
begin
	if (rst)
		glitchy_counter <= 0;
	else if (Q[3] == 1)
		glitchy_counter <= glitchy_counter - 5;
	else
		glitchy_counter <= glitchy_counter + 2;
end

endmodule




