module ForwardingUnit(
    input [4:0] ID_EX_RS1,
    input [4:0] ID_EX_RS2,
    input [4:0] EX_MEM_RD,
    input [4:0] MEM_WB_RD,
    input EX_MEM_RegW,
    input MEM_WB_RegW,
    output wire [1:0] MuxA,
    output wire [1:0] MuxB
);

reg [1:0] MuxA_reg = 2'b00;
reg [1:0] MuxB_reg = 2'b00;

// Data forwarding logic
always @* begin
    // Handling EX_MEM_RegW
    case (EX_MEM_RegW)
        1'b1: begin
            if (EX_MEM_RD == ID_EX_RS1)
                MuxA_reg = 2'b10;
            else
                MuxA_reg = 2'b00;
            if (EX_MEM_RD == ID_EX_RS2)
                MuxB_reg = 2'b10;
            else
                MuxB_reg = 2'b00;
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
            if (MEM_WB_RD == ID_EX_RS1)
                MuxA_reg = 2'b01;
            if (MEM_WB_RD == ID_EX_RS2)
                MuxB_reg = 2'b01;
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
