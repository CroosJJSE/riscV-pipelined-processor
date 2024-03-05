`timescale 1ns / 1ps
module main_ALU (
    input [31:0] A, B,            // Inputs A and B
    input [6:0] ALU_control,      // ALU control signals
    output reg [31:0] ALU_result, // Output result
    output reg zero,              // Zero flag
    output reg overflow,          // Overflow flag
    output reg negative           // Negative flag
);

// ALU computation
always @* begin
    case (ALU_control)
        7'b0011100: begin   // ADD 
            ALU_result = A + B;
            overflow = (A[31] == B[31]) && (ALU_result[31] != A[31]);
        end
        7'b0011101: begin   // SUB
            ALU_result = A - B;
            overflow = (A[31] != B[31]) && (ALU_result[31] != A[31]);
        end
        7'b0011110: ALU_result = A << B; // SLL Shift left logical
        7'b0011111: ALU_result = (A < B) ? 1 : 0; // SLT Set Less Than
        7'b0100000: ALU_result = (A < B) ? 1 : 0; // SLTU Set Less Than unsigned
        7'b0100001: ALU_result = A ^ B; // XOR 
        7'b0100010: ALU_result = A >> B; // SRL Shift Right Logical
        7'b0100011: begin   // SRA Shift Right Arithmetic
            ALU_result = (A[31] == 1) ? {A[31], A[31:1]} >> B : A >> B;
        end
        7'b0100100: ALU_result = A | B; // OR 
        7'b0100101: ALU_result = A & B; // AND 
        7'b1111000: begin
            // ALU_result= A << $clog2(B); //unsigned mul 
        end
        default: ALU_result = 0; // Default: Set result to 0
    endcase
end

// Flags computation
always @* begin
    zero = (ALU_result == 0) ? 1 : 0; // Zero flag  
    negative = (ALU_result[31] == 1) ? 1 : 0; // Negative flag 
end

endmodule
