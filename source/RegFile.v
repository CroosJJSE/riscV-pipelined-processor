`timescale 1ns / 1ps
module RegFile (
    input wire [4:0] read_regA, read_regB, write_reg,
    input wire write_enable, clk, reset,
    input wire [31:0] write_data,
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
        register_File[1] = 32'h1;
        register_File[2] = 32'h2;
        register_File[3] = 32'h3;
        register_File[4] = 32'h4;
        register_File[5] = 32'h5;
        register_File[6] = 32'h6;
        register_File[7] = 32'h7;
        register_File[8] = 32'h8;
        register_File[9] = 32'h9;
        register_File[10] = 32'ha;
        register_File[11] = 32'hb;
        register_File[12] = 32'hc;
        register_File[13] = 32'hd;
        register_File[14] = 32'he;
        register_File[15] = 32'hf;
        register_File[16] = 32'h10;


    end

    assign read_dataA = register_File[read_regA];
    assign read_dataB = register_File[read_regB];

endmodule

