module EX_MEM_Register (
    input wire clk,
    input wire reset,
    input wire [31:0] pc_EXMEM_in,
    input wire [31:0] instruction_EXMEM_in,
    input wire [31:0] regOut_B_EXMEM_in,
    input wire [31:0] ALU_result_EXMEM_in,
    input wire RegWEn_EXMEM_in,
    input wire MemRW_EXMEM_in,
    input wire [1:0]WBsel_EXMEM_in,
    output reg [31:0] pc_EXMEM_out,    
    output reg [31:0] instruction_EXMEM_out,   
    output reg [31:0] ALU_result_EXMEM_out,    
    output reg [31:0] regOut_B_EXMEM_out,    
    output reg RegWEn_EXMEM_out,    
    output reg MemRW_EXMEM_out,    
    output reg [1:0]WBsel_EXMEM_out
    
);
    
    // Register for EX/MEM stage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_EXMEM_out <= 0;
            instruction_EXMEM_out <= 0;

            regOut_B_EXMEM_out <= 0;
            RegWEn_EXMEM_out <= 0;
            MemRW_EXMEM_out <= 0;
            WBsel_EXMEM_out <= 0;
        end else begin
            pc_EXMEM_out <= pc_EXMEM_in;
            instruction_EXMEM_out <= instruction_EXMEM_in;
            regOut_B_EXMEM_out <= regOut_B_EXMEM_in;
            RegWEn_EXMEM_out <= RegWEn_EXMEM_in;
            MemRW_EXMEM_out <= MemRW_EXMEM_in;
            WBsel_EXMEM_out <= WBsel_EXMEM_in;
        end
    end

endmodule
