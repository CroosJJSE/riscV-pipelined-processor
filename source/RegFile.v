`timescale 1ns / 1ps
module RegFile (
    input [4:0] read_regA, read_regB, write_reg,
    input write_enable, clk, reset,
    input [31:0] write_data,
    output [31:0] read_dataA, read_dataB
);

    // Memory
    reg [31:0] register_File [31:0];

    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 1; i < 32; i = i + 1) begin
                register_File[i] <= 32'h0;
            end
        end
        else if (write_enable) begin
            register_File[write_reg] <= write_data;
        end
    end

    initial begin
        register_File[0] = 32'h0;

    end

    assign read_dataA = register_File[read_regA];
    assign read_dataB = register_File[read_regB];

endmodule

