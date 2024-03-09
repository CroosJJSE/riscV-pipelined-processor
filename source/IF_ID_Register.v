module IF_ID_Register #(
    parameter DATA_WIDTH = 32
)(
    input clk,                       // Clock input
    input reset,                     // Reset input
    input stall,                     // Stall input
    input [DATA_WIDTH-1:0] instruction_IFID_in,
    input [DATA_WIDTH-1:0] pc_IFID_in,
    output reg [DATA_WIDTH-1:0] pc_IFID_out,
    output reg [DATA_WIDTH-1:0] instruction_IFID_out
);

// Registers for IF/ID stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        instruction_IFID_out <= 0;
        pc_IFID_out <= 0;
    end else begin
        if (stall) begin
            // Hold the current values when stall is asserted
            instruction_IFID_out <= instruction_IFID_out;
            pc_IFID_out <= pc_IFID_out;
        end else begin
            instruction_IFID_out <= instruction_IFID_in;
            pc_IFID_out <= pc_IFID_in;
        end
    end
end

endmodule
