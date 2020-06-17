`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:43:01 05/09/2020 
// Design Name: 
// Module Name:    clock_div_hundred 
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
module clock_div_hundred(
    input clk_in,
    input rst,
    output reg clk_div_200
    );
 
reg [99:0] Q;
always @ (posedge clk_in)
begin
	if (rst)
	begin
		Q <= {1'b1,{99{1'b0}}};
	end
	else
		Q <= {Q[98:0],Q[99]};
end
always @ (posedge clk_in)
begin
	if (rst)
		clk_div_200 <= 0;
	if(Q[99])
		clk_div_200 <= ~clk_div_200;
end

endmodule
