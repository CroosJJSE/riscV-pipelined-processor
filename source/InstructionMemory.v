`timescale 1ns / 1ps
module InstructionMemory (
    input [31:0] pc_in,               // Program counter (input)
    output reg [31:0] instruction     // Output instruction
);

    reg [31:0] memory [0:255];  // Define the instruction memory as an array of 32-bit instructions

    // Initialize the instruction memory with your program instructions
    initial begin
            //memory[0] = 32'b0000000_00001_00000_000_00001_0010011; // ADDI
            //memory[1] = 32'b0000000_00001_00001_000_00010_0010011; // ADDI
           //memory[1] = 32'b0000000_00010_00001_000_00011_0110011;  // ADD r3 <- r1 + r2 should forward from WB to  inst3 
           //memory[2] = 32'b0000000_00010_00011_000_00100_0110011;  // ADD r4 <- r2 + r3 should forward from EXMEM to inst3
           //memory[3] = 32'b0000000_00010_00011_000_01000_0110011;  // ADD r8 <- r2 + r3
           //memory[4] = 32'b0000000_00011_00001_000_00111_0110011;  // ADD, writes to register x3
           //memory[5] = 32'b0000000_00010_00011_000_00100_0110011;  // ADD, writes to register x4
           //memory[6] = 32'b0000000_00001_00010_000_00101_0110011;  // ADD, writes to register x5

            //memory[3] = 32'b0100000_00001_00010_000_00100_0010011; //  SUB
            //memory[1] = 32'b0000000_00010_00001_010_00101_0100011; // SW rs2 2, rs1 0, imm 5
            memory[1] = 32'b0000000_00001_00101_010_00011_0000011; // LW rd 3, rs1 1, imm 6
            memory[2] = 32'b0000000_00010_00011_000_00100_0110011;  // ADD
            //memory[6] = 32'b0000000_00001_00110_000_00111_0010011; // ADDI
            //memory[2] = 32'b0000000_00011_00011_000_01000_1100011; // BEQ
            //memory[9] = 32'b0000000_00000_00011_001_00100_1100011; // BNE
            //memory[11] = 32'b0000000_00011_00011_001_00100_1100011; // BNE wont branch.
            //memory[12] = 32'b0000000_00001_00110_000_00111_0010011; // ADDI
            //memory[1] = 32'b0_0000000111_0_00000000_00011_1101111; // JAL IMM 3
            //memory[17] = 32'b0000000_00101_00011_000_01111_0010011; // ADDI
            //memory[18] = 32'b00000000_0000_01111_000_11111_1100111; // JALR
            //memory[20] = 32'b0000000_00011_11111_000_00111_0010011; // ADDI   
    end//

    always @* begin
        instruction = memory[pc_in];
    end

endmodule


