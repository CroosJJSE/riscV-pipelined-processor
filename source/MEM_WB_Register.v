module MEM_WB_Register(
    input clk,
    input reset,
    output reg [31:0] instruction_MEMWB_out,
    input wire [31:0] instruction_MEMWB_in,
    input wire [31:0] DMEM_mux_MEMWB_in,
    output reg [31:0] DMEM_mux_MEMWB_out,
    output reg RegWEn_MEMWB_out,
    input wire RegWEn_MEMWB_in
);

// Register for MEM/WB stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        instruction_MEMWB_out <= 0;
        DMEM_mux_MEMWB_out <= 0;
        RegWEn_MEMWB_out <= 0;
    end else begin
        instruction_MEMWB_out <= instruction_MEMWB_in;
        DMEM_mux_MEMWB_out <= DMEM_mux_MEMWB_in;
        RegWEn_MEMWB_out <= RegWEn_MEMWB_in;
    end
end

endmodule
