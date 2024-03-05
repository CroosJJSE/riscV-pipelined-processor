`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2023 04:39:43 PM
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder (
    input [31:0] val_in,
    input [31:0] val_in2,
    output reg [31:0] val_out
);

    always @* begin
        val_out = val_in + val_in2;
    end

endmodule
