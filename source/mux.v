`timescale 1ns / 1ps
module mux (
    input sel,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out
);

   always @* begin
       if (!sel)
           out = in0;
       else
           out = in1;
   end

endmodule
