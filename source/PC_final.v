`timescale 1ns / 1ps
module PC_final (
    input clk,
    input reset,
    input [31:0] pc_in,
    output [31:0] pc_out
);

    reg [31:0] pc_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_reg <= 32'b0;
        end else begin
            pc_reg <= pc_in;
        end
    end

    assign pc_out = pc_reg;

endmodule
