`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:27 05/08/2020 
// Design Name: 
// Module Name:    clock_div_thirty_two 
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
module clock_div_thirty_two(
    input clk_in,
    input rst,
    output reg clk_div_32
    );
reg [3:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
	begin
		Q <= 4'b0000;
		clk_div_32 <= 0;
	end
	else if (Q == 4'b1111)
	begin
		clk_div_32 <= ~clk_div_32;
		Q <= Q + 1'b1;
	end
	else
	begin
		Q <= Q + 1'b1;
	end
end


endmodule
