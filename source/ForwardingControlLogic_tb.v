module ForwardingControlLogic_tb;

reg [31:0] current_instr;
reg [31:0] prev_instr;
reg control_signal;
wire forward_control;

ForwardingControlLogic uut (
    .current_instr(current_instr),
    .prev_instr(prev_instr),
    .control_signal(control_signal),
    .forward_control(forward_control)
);

initial begin
    // Test case 1: No forwarding needed
    current_instr = 32'b0000000_00001_00000_000_00001_0010011; // ADDI // Destination register: x5
    prev_instr    = 32'b0000000_00001_00001_000_00001_0010011; // ADDI  // Source registers: x1, x2
    control_signal = 1'b1;
    #10;

    // Test case 2: Forwarding needed
    current_instr = 32'b0000000_00001_00000_000_00001_0010011; // ADDI // Destination register: x5
    prev_instr    = 32'b0000000_00001_00000_000_00011_0010011; // ADDI  // Source registers: x1, x2
    control_signal = 1'b1;
    #10;

    // Test case 3: No forwarding needed (control signal inactive)
    current_instr = 32'b0000000_00001_00000_000_00001_0010011; // ADDI // Destination register: x5
    prev_instr    = 32'b0000000_00001_00001_000_00001_0010011; // ADDI  // Source registers: x1, x2
    control_signal = 1'b0;
    #10;

    // Add more test cases as needed

    $finish;
end

endmodule
