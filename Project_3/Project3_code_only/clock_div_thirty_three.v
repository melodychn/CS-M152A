`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:08:34 05/08/2020 
// Design Name: 
// Module Name:    clock_div_thirty_three 
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
module clock_div_thirty_three(
    input clk_in,
    input rst,
    output clk_div_33,
	 output clk_div_33_neg,
	 output clk_div_33_or
    );
	 
reg [2:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
	begin
		Q <= 3'b100;
	end
	else
		Q <= {Q[1:0],Q[2]};
end
assign clk_div_33 = Q[2];
reg [2:0] Q_neg;
always @ (negedge clk_in)
begin
	if (rst)
	begin
		Q_neg <= 3'b100;
	end
	else
		Q_neg <= {Q_neg[1:0],Q_neg[2]};
end
assign clk_div_33_neg = Q_neg[2];
assign clk_div_33_or = Q_neg[2] || Q[2];
endmodule
