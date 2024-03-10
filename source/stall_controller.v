module stall_controller(
    input [31:0] new_instruction,
    input [31:0] IDEX_instruction_out,
    input [31:0] EXMEM_instruction_out,
    input [31:0] MEMWB_instruction_out,
    output reg stall
);

// Extracting opcode from the new_instruction
reg [6:0] opcode_new;
reg [4:0] rs1_new, rs2_new;
reg re1, re2;

always @* begin
    opcode_new = new_instruction[6:0];
    if (opcode_new == 7'b0110011) begin  // R-type
        rs1_new = new_instruction[19:15];
        re1 = 1'b1;
        rs2_new = new_instruction[24:20];
        re2 = 1'b1;
    end
    else if (opcode_new == 7'b0010011 || opcode_new == 7'b1100111 || opcode_new == 7'b0000011) begin // I-type and jalr and load
        rs1_new = new_instruction[19:15];
        re1 = 1'b1;
        re2 = 1'b0;
    end
    else begin
        re1 = 1'b0;
        re2 = 1'b0;
    end
end

// Extracting opcode from the IDEX_instruction_out
reg [6:0] opcode_IDEX;
reg weEX;
reg [4:0] rd_IDEX;

always @* begin
    opcode_IDEX = IDEX_instruction_out[6:0];
    if (opcode_IDEX == 7'b0010011 || opcode_IDEX == 7'b1100111 || opcode_IDEX == 7'b0000011 || opcode_IDEX == 7'b0110011) begin 
        weEX = 1'b1;
        rd_IDEX = IDEX_instruction_out[11:7];
    end
    else begin
        weEX = 1'b0;
    end
end

// Extracting opcode from the EXMEM_instruction_out
reg [6:0] opcode_EXMEM;
reg weMEM;
reg [4:0] rd_EXMEM;

always @* begin
    opcode_EXMEM = EXMEM_instruction_out[6:0];
    if (opcode_EXMEM == 7'b0010011 || opcode_EXMEM == 7'b1100111 || opcode_EXMEM == 7'b0000011 || opcode_EXMEM == 7'b0110011) begin 
        weMEM = 1'b1;
        rd_EXMEM = EXMEM_instruction_out[11:7];
    end
    else begin
        weMEM = 1'b0;
    end
end

// Extracting opcode from the MEMWB_instruction_out
reg [6:0] opcode_MEMWB;
reg weWB;
reg [4:0] rd_MEMWB;

always @* begin
    opcode_MEMWB = MEMWB_instruction_out[6:0];
    if (opcode_MEMWB == 7'b0010011 || opcode_MEMWB == 7'b1100111 || opcode_MEMWB == 7'b0000011 || opcode_MEMWB == 7'b0110011) begin 
        weWB = 1'b1;
        rd_MEMWB = MEMWB_instruction_out[11:7];
    end
    else begin
        weWB = 1'b0;
    end
end

// Logic for stalling
always @* begin
    // Default: No stall
    stall = 0;
    if ((rs1_new == rd_IDEX) && (re1 == 1'b1) && (opcode_IDEX == 7'b0000011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end
    else if ((rs2_new == rd_IDEX) && (re2 == 1'b1) && (opcode_IDEX == 7'b0000011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end


    else if ((rs1_new == rd_EXMEM) && (re1 == 1'b1) && (opcode_EXMEM == 7'b0000011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end
    else if ((rs2_new == rd_EXMEM) && (re2 == 1'b1) && (opcode_EXMEM == 7'b0000011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end


    else if ((rs1_new == rd_MEMWB) && (re1 == 1'b1) && (opcode_MEMWB == 7'b0000011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end
    else if ((rs2_new == rd_MEMWB) && (re2 == 1'b1) && (opcode_MEMWB == 7'b0000011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end


    else if ((rs1_new == rd_IDEX) && (re1 == 1'b1) && (opcode_IDEX == 7'b0110011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end
    else if ((rs2_new == rd_IDEX) && (re2 == 1'b1) && (opcode_IDEX == 7'b0110011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end


    else if ((rs1_new == rd_EXMEM) && (re1 == 1'b1) && (opcode_EXMEM == 7'b0110011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end
    else if ((rs2_new == rd_EXMEM) && (re2 == 1'b1) && (opcode_EXMEM == 7'b0110011)) begin
        // Data hazard detected, insert stall
        stall = 1;
    end
    else begin
        stall = 0;
    end
end

endmodule
