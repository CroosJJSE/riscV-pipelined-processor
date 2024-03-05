`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2024 12:36:46 PM
// Design Name: 
// Module Name: risc
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


module risc(
    input clk,reset,
    output [31:0] instruction,aluOut,PC,
    output led1,led2,led3,led4
    );

wire wire_clk; // wire to connect clockDivider to top
wire [31:0] wire_instruction; 
wire [31:0] wire_aluOut;
wire [31:0] wire_PC;
wire wire_led;


// intantiate clockDivider
ClockDivider clkDiv(
  .clk_50MHz(clk),
  .clk_div(wire_clk)
    
    );
    

//intantiate top
top top_inst(
    .clk(wire_clk),
     //.clk(clk),
    .reset(reset),
    .instruction(instruction),
    .aluOut(aluOut),
    .PC(wire_PC)
    );
 
 LEDController  LEDController(
    .data(wire_PC),   
    .led1(led1),
    .led2(led2),
    .led3(led3),
    .led4(led4)
 );
 assign PC = wire_PC;
  
endmodule
