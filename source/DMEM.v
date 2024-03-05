`timescale 1ns / 1ps
module DMEM(
    input  [31:0] addr,
    input  [31:0] data_W,
    output [31:0] data_R,
    input   memwrite,
    input   clk
);

reg [31:0] mem [1023:0];
reg [31:0] data_R_reg;
initial begin
    mem[0] = 32'd0;
    mem[1] = 32'd1;
    mem[2] = 32'd2;
    mem[3] = 32'd3;
    mem[4] = 32'd4;
    mem[5] = 32'd5;
    mem[6] = 32'd6000;
    mem[7] = 32'd7;
    mem[8] = 32'd8;
    mem[9] = 32'd9;
    mem[10] = 32'd10;
    mem[11] = 32'd11;
    mem[12] = 32'd12;
    mem[13] = 32'd13;
    mem[14] = 32'd14;
    mem[15] = 32'd15;
end

always @* begin // Equivalent to always_comb
    data_R_reg = mem[addr];
end

always @(posedge clk) begin // Equivalent to always_ff
    if (memwrite) begin
        mem[addr] <= data_W;
    end
end
assign data_R = data_R_reg;
endmodule
