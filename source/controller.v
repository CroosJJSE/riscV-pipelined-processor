`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 09:58:56 PM
// Design Name: 
// Module Name: controller
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


module controller (
    input [31:0] inst,
    input BrLT,
    input BrEq,
    output [6:0] ALU_control,
    output PCSel,
    output [2:0] ImmSel,
    output RegWEn,
    output ASel,
    output BSel,
    output MemRW,
    output BrUn,
    output [1:0] WBSel
);

    reg [6:0] ALU_control_temp;
    wire [10:0] control_signal;
    reg PC_temp = 1'b0 ;
    reg [1:0] WBSel_reg;
    reg ASel_reg;
    reg BSel_reg;
    reg [2:0] ImmSel_reg;
    reg RegWEn_reg;
    reg MemRW_reg;
    reg BrUn_reg;

    assign control_signal = {inst[30], inst[14:12], inst[6:0]};

    always @* begin
        case (control_signal[6:0])
            7'b0110011: begin // alu r-type
                ASel_reg = 1'b0;
                BSel_reg = 1'b0; 
                ImmSel_reg = 3'b000;
                PC_temp = 1'b0;
                RegWEn_reg = 1'b1;
                WBSel_reg = 1'b1;
                case (control_signal[10:7])
                    17'b0_000: ALU_control_temp = 7'b0011100; // add
                    17'b1_000: ALU_control_temp = 7'b0011101; // sub
                    17'b0_001: ALU_control_temp = 7'b0011110; // sll
                    17'b0_010: ALU_control_temp = 7'b0011111; // slt
                    17'b0_011: ALU_control_temp = 7'b0100000; // sltu
                    17'b0_100: ALU_control_temp = 7'b0100001; // xor
                    17'b0_101: ALU_control_temp = 7'b0100010; // srl
                    17'b1_101: ALU_control_temp = 7'b0100011; // sra
                    17'b0_110: ALU_control_temp = 7'b0100100; // or
                    17'b0_111: ALU_control_temp = 7'b0100101; // and
                    default: ALU_control_temp = 7'b1111111;
                endcase
            end // 00101000

            7'b0010011: begin // immediate
                ImmSel_reg = 3'b001;
                ASel_reg = 1'b0;
                BSel_reg = 1'b1;
                PC_temp = 1'b0;
                RegWEn_reg = 1'b1;
                WBSel_reg = 1'b1;
                case (control_signal[9:7])
                    3'b000: ALU_control_temp = 7'b0011100; // ADDI
                    3'b010: ALU_control_temp = 7'b1111111; // SLTI  // ALU out is zero but negative flag will be 1.
                    3'b011: ALU_control_temp = 7'b1111111; // SLTIU // ALU out is zero but negative flag will be 1.
                    3'b100: ALU_control_temp = 7'b0100001; // XORI
                    3'b110: ALU_control_temp = 7'b0100100; // ORI
                    3'b111: ALU_control_temp = 7'b0100101; // ANDI
                    3'b001: ALU_control_temp = 7'b0011110; // SLLI

                    3'b101: begin // SRLI or SRAI
                        if (control_signal[10] == 1'b0) ALU_control_temp = 7'b0100010; // SRLI
                        else ALU_control_temp = 7'b0100011; // SRAI
                    end
                endcase
            end

            7'b0000011: begin // load
                ImmSel_reg = 3'b001;
                ASel_reg = 1'b0;
                BSel_reg = 1'b1;
                ALU_control_temp = 7'b0011100;
                WBSel_reg = 2'b00;
                RegWEn_reg = 1'b1;
                PC_temp = 1'b0;
            end

            7'b0100011: begin // store
                ImmSel_reg = 3'b010;
                ASel_reg = 1'b0;
                BSel_reg = 1'b1;
                ALU_control_temp = 7'b0011100;
                MemRW_reg = 1'b1;
                WBSel_reg = 2'b00;
                RegWEn_reg = 1'b0;
                PC_temp = 1'b0;
            end
  
            7'b1100011: begin // branch
                ImmSel_reg = 3'b100;
                ASel_reg = 1'b1;
                BSel_reg = 1'b1;
                RegWEn_reg = 1'b0;
                WBSel_reg = 2'b00;
                MemRW_reg = 1'b0;
                ALU_control_temp = 7'b0011100;

                case (control_signal[9:7])
                    3'b000: begin // BEQ
                        if (BrEq) PC_temp = 1'b1;
                        else PC_temp = 1'b0;
                    end
                    3'b100: begin // BLT
                        if (BrLT) PC_temp = 1'b1;
                        else PC_temp = 1'b0;
                    end
                    3'b001: begin // BNE
                        if (!BrEq) PC_temp = 1'b1;
                        else PC_temp = 1'b0;
                    end
                    3'b101: begin // BGE
                        if (!BrLT) PC_temp = 1'b1;
                        else PC_temp = 1'b0;
                    end
                    3'b110: begin // BLTU
                        BrUn_reg = 1'b1;
                        if (BrLT) PC_temp = 1'b1;
                        else PC_temp = 1'b0;
                    end
                    3'b111: begin // BGEU
                        BrUn_reg = 1'b1;
                        if (!BrLT) PC_temp = 1'b1;
                        else PC_temp = 1'b0;
                    end
                    
                endcase
            end


            7'b1101111: begin // JAL
                ASel_reg = 1'b1;  
                BSel_reg = 1'b1;
                RegWEn_reg = 1'b1;
                ImmSel_reg = 3'b101;
                PC_temp = 1'b1;
                ALU_control_temp = 7'b0011100;
                WBSel_reg = 2'b10;

            end
            7'b1100111: begin // JALR
                ImmSel_reg = 3'b001;
                PC_temp = 1'b1;
                RegWEn_reg = 1'b1;
                WBSel_reg = 2'b10;
                ASel_reg = 1'b0;  
                BSel_reg = 1'b1;
                ALU_control_temp = 7'b0011100;
            end

            7'b0010111: begin // AUIPC
                ImmSel_reg = 3'b011;
                ASel_reg = 1'b1;
                BSel_reg = 1'b1;
                RegWEn_reg = 1'b1;
                ALU_control_temp = 7'b0011100;
                PC_temp = 1'b0;
                WBSel_reg = 2'b01;
            end



        endcase
    end

    assign PCSel = PC_temp;
    assign ALU_control = ALU_control_temp;
    assign WBSel = WBSel_reg;
    assign BSel = BSel_reg;
    assign ASel = ASel_reg;
    assign ImmSel = ImmSel_reg;
    assign RegWEn = RegWEn_reg;
    assign MemRW = MemRW_reg;
    assign BrUn = BrUn_reg;
endmodule
