`timescale 1ns / 1ps
module PC_final (
    input clk,
    input reset,
    input stall,
    input [31:0] pc_in,
    output [31:0] pc_out
);

    reg [31:0] pc_reg;
    reg [31:0] pc_stalled;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_reg <= 32'b0;
        end else begin
            pc_reg <= stall ? pc_stalled : pc_in;
        end
    end

    always @* begin
        pc_stalled = pc_reg; // Hold the current PC value when stall is asserted
    end

    assign pc_out = pc_reg;

endmodule
