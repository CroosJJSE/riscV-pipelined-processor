`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2024 12:30:53 PM
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider(
    input wire clk_50MHz,
    output wire clk_div
);

parameter CLK_FREQ = 50_000_000; // 50 MHz
parameter DESIRED_PERIOD = 250_000_000; // 2 seconds

reg reg_clk_div;
reg [31:0] counter;

always @(posedge clk_50MHz) begin
    if (counter == DESIRED_PERIOD - 1) begin
        counter <= 0;
        reg_clk_div <= ~reg_clk_div;
    end else begin
        counter <= counter + 1;
    end
end

assign clk_div = reg_clk_div; // Assigning reg_clk_div to clk_div outside the always block

endmodule

