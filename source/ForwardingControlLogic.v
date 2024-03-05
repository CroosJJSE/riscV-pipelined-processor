module ForwardingControlLogic (
    input [31:0] current_instr,
    input [31:0] prev_instr,
    input control_signal,
    output reg forward_control
);
reg [4:0] src_reg1_curr ;
reg [4:0] src_reg2_curr ;
reg [4:0] dest_reg_prev ;
always @(*) begin
    // Extracting the source registers from the current instruction
    src_reg1_curr = current_instr[19:15];
    src_reg2_curr = current_instr[24:20];
    // Extracting the destination register from the previous instruction
    dest_reg_prev = prev_instr[11:7];

    // Check if the source registers of the current instruction match the destination register of the previous instruction
    if ((src_reg1_curr == dest_reg_prev || src_reg2_curr == dest_reg_prev) && control_signal) begin
        // If there is a match and the control signal is active, enable forwarding
        forward_control = 1;
    end else begin
        // Otherwise, disable forwarding
        forward_control = 0;
    end
end

endmodule
