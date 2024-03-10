module ForwardingUnit(
    input [31:0] instruction_IDEX, // Instruction in the ID/EX stage
    input [31:0] instruction_EXMEM, // Instruction in the EX/MEM stage
    input [31:0] instruction_MEMWB, // Instruction in the MEM/WB stage
    input EX_MEM_RegW,
    input MEM_WB_RegW,
    output wire [1:0] MuxA,
    output wire [1:0] MuxB
);

reg [1:0] MuxA_reg = 2'b00;
reg [1:0] MuxB_reg = 2'b00;
reg [6:0] opcode_IDEX;
reg [6:0] opcode_EXMEM;
reg [6:0] opcode_MEMWB;

// Data forwarding logic
always @* begin
    // Extract opcode from the instruction_IDEX
    opcode_IDEX = instruction_IDEX[6:0];
    opcode_EXMEM = instruction_EXMEM[6:0];
    opcode_MEMWB = instruction_MEMWB[6:0];


    // Handling EX_MEM_RegW
    case (EX_MEM_RegW)
        1'b1: begin
            if (opcode_EXMEM[6:0] == 7'b0110011 || opcode_EXMEM[6:0] == 7'b0010011) begin
                if (instruction_EXMEM[19:15] == instruction_IDEX[19:15]) // Check if rs1 matches
                    MuxA_reg = 2'b10;
                if (instruction_EXMEM[24:20] == instruction_IDEX[24:20]) // Check if rs2 matches
                    MuxB_reg = 2'b10;
            end
            else begin
                // Reset MuxA_reg and MuxB_reg if opcode is not for R-type or I-type instructions
                MuxA_reg = 2'b00;
                MuxB_reg = 2'b00;
            end

        end
        1'b0: begin
            // Reset MuxA_reg and MuxB_reg if EX_MEM_RegW is not asserted
            MuxA_reg = 2'b00;
            MuxB_reg = 2'b00;
        end
    endcase

    // Handling MEM_WB_RegW
    case (MEM_WB_RegW)
        1'b1: begin
            if (opcode_MEMWB[6:0] == 7'b0110011 || opcode_MEMWB[6:0] == 7'b0010011) begin
                if (instruction_MEMWB[19:15] == instruction_IDEX[19:15]) // Check if rs1 matches
                    MuxA_reg = 2'b01;
                if (instruction_MEMWB[24:20] == instruction_IDEX[24:20]) // Check if rs2 matches
                    MuxB_reg = 2'b01;
            end
            else begin
                // Reset MuxA_reg and MuxB_reg if opcode is not for R-type or I-type instructions
                MuxA_reg = 2'b00;
                MuxB_reg = 2'b00;
            end

        end
        1'b0: begin
            // Reset MuxA_reg and MuxB_reg if MEM_WB_RegW is not asserted
            MuxA_reg = 2'b00;
            MuxB_reg = 2'b00;
        end
    endcase
end


assign MuxA = MuxA_reg;
assign MuxB = MuxB_reg;

endmodule
