`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2024 10:36:22 PM
// Design Name: 
// Module Name: LEDController
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


module LEDController(
    input [31:0] data,
    output reg led1,led2,led3,led4
);

always @(*) begin
    led1 = data[3];
    led2 = data[2];
    led3 = data[1];
    led4 = data[0];
end

endmodule

