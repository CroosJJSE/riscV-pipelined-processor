module ID_EX_Register(
    input wire clk,
    input wire reset,
    input wire [31:0] pc_IFID_input,
    input wire [31:0] instruction_IDEX_in,
    input wire [31:0] ALU_control_IDEX_in,
    input wire BSel_IDEX_in,
    input wire ASel_IDEX_in,
    input wire RegWEn_IDEX_in,
    input wire BrUn_IDEX_in,
    input wire MemRW_IDEX_in,
    input wire WBsel_IDEX_in,
    input wire ImmSel_IDEX_in,
    input wire [31:0] regOut_A_IDEX_in,
    input wire [31:0] regOut_B_IDEX_in,
    output reg [31:0] pc_IFID_output,
    output reg [31:0] instruction_IDEX_out,
    output reg [31:0] ALU_control_IDEX_out,
    output reg BSel_IDEX_out,
    output reg ASel_IDEX_out,
    output reg RegWEn_IDEX_out,
    output reg BrUn_IDEX_out,
    output reg MemRW_IDEX_out,
    output reg WBsel_IDEX_out,
    output reg ImmSel_IDEX_out,
    output reg [31:0] regOut_A_IDEX_out,
    output reg [31:0] regOut_B_IDEX_out

);
    
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                pc_IFID_output <= 32'b0;
                instruction_IDEX_out <= 32'b0;
                ALU_control_IDEX_out <= 32'b0;
                BSel_IDEX_out <= 1'b0;
                ASel_IDEX_out <= 1'b0;
                RegWEn_IDEX_out <= 1'b0;
                BrUn_IDEX_out <= 1'b0;
                MemRW_IDEX_out <= 1'b0;
                WBsel_IDEX_out <= 2'b0;
                ImmSel_IDEX_out <= 3'b0;
            end else begin
                pc_IFID_output <= pc_IFID_input;
                instruction_IDEX_out <= instruction_IDEX_in;
                ALU_control_IDEX_out <= ALU_control_IDEX_in;
                BSel_IDEX_out <= BSel_IDEX_in;
                ASel_IDEX_out <= ASel_IDEX_in;
                RegWEn_IDEX_out <= RegWEn_IDEX_in;
                BrUn_IDEX_out <= BrUn_IDEX_in;
                MemRW_IDEX_out <= MemRW_IDEX_in;
                WBsel_IDEX_out <= WBsel_IDEX_in;
                ImmSel_IDEX_out <= ImmSel_IDEX_in;
            end
        end

endmodule