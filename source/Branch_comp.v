`timescale 1ns / 1ps
module Branch_comp (
    input [31:0] A,
    input [31:0] B,
    input BrUn,
    output reg BrEq,
    output reg BrLT
);

    always @* begin : Bran_comp
        // Unsigned comparison
        BrEq = (A == B);
        
        // Signed comparison
        if (BrUn) begin
            BrLT = (A < B);
        end else begin
            BrLT = (A[31] < B[31]) ? 1'b1 : (A[31] == B[31]) ? (A < B) : 1'b0;
        end
    end

endmodule
