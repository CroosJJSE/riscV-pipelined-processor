`timescale 1ns / 1ps
module top (
    input clk, reset
);

// Wires
wire [31:0] wire_pc;
wire [31:0] wire_pc_IFID_out;
wire [31:0] wire_pc_IDEX_out;
wire [31:0] wire_pc_EXMEM_out;

wire [31:0] wire_instruction;
wire [31:0] wire_instruction_IFID_out;
wire [31:0] wire_instruction_IDEX_out;
wire [31:0] wire_instruction_EXMEM_out;
wire [31:0] wire_instruction_MEMWB_out;



wire [31:0] wire_regOut_A;
wire [31:0] wire_regOut_A_IDEX_out;
wire [31:0] wire_regOut_A_EXMEM_out;




wire [31:0] wire_regOut_B;
wire [31:0] wire_regOut_B_IDEX_out;
wire [31:0] wire_regOut_B_EXMEM_out;
wire [31:0] wire_regOut_B_MEMWB_out;

wire [31:0] wire_IMM_mux_out_B;
wire [31:0] wire_A_mux_out_A;
wire [31:0] wire_im_gen;

wire [31:0] wire_ALU_result;
wire [31:0] wire_ALU_result_EXMEM_out;

wire [6:0] wire_ALU_control;
wire [6:0] wire_ALU_control_IDEX_out;

wire [31:0] wire_dataR;



wire [31:0] wire_Data_DMEM;
wire [31:0] wire_Data_DMEM_WB_out;

wire [31:0] wire_pc4;
wire [31:0] wire_pc_mux_out;
wire [31:0] wire_Next_PCm;

wire zero;
wire overflow;
wire negative;

wire wire_PCSel;
wire wire_PCSel_IDEX_out;

wire wire_BSel;
wire wire_BSel_IDEX_out;

wire wire_ASel;
wire wire_ASel_IDEX_out;

wire wire_RegWEn;
wire wire_RegWEn_IDEX_out;
wire wire_RegWEn_EXMEM_out;
wire wire_RegWEn_MEMWB_out;

wire wire_BrUn;
wire wire_BrUn_IDEX_out;

wire wire_BrEq;

wire wire_BrLT;

wire wire_MemRW;
wire wire_MemRW_IDEX_out;
wire wire_MemRW_EXMEM_out;


wire [1:0] wire_WBsel;
wire [1:0] wire_WBsel_IDEX_out;
wire [1:0] wire_WBsel_EXMEM_out;

wire [2:0] wire_ImmSel;
wire [2:0] wire_ImmSel_IDEX_out ;

// Instantiate instruction memory
InstructionMemory instruction_memory (
    .pc_in(wire_pc),
    .instruction(wire_instruction)
);
// intantiate IF_ID_Register
IF_ID_Register IF_ID_register (
    .clk(clk),
    .reset(reset),
    .instruction_IFID_in(wire_instruction),
    .instruction_IFID_out(wire_instruction_IFID_out),
    .pc_IFID_in(wire_pc),
    .pc_IFID_out(wire_pc_IFID_out)
);

ID_EX_Register ID_EX_register (
    .clk(clk),
    .reset(reset),
    //data in
    .pc_IFID_input(wire_pc_IFID_out),
    .instruction_IDEX_in(wire_instruction_IFID_out),
    .regOut_A_IDEX_in(wire_regOut_A),
    .regOut_B_IDEX_in(wire_regOut_B),
    .PCSel(wire_PCSel),

    //data out
    .pc_IFID_output(wire_pc_IDEX_out),
    .regOut_A_IDEX_out(wire_regOut_A_IDEX_out),
    .regOut_B_IDEX_out(wire_regOut_B_IDEX_out),
    .instruction_IDEX_out(wire_instruction_IDEX_out),
    .PCSel_IDEX_out(wire_PCSel_IDEX_out),

    // control in
    .ALU_control_IDEX_in(wire_ALU_control),
    .BSel_IDEX_in(wire_BSel),
    .ASel_IDEX_in(wire_ASel),
    .RegWEn_IDEX_in(wire_RegWEn),
    .BrUn_IDEX_in(wire_BrUn),
    .MemRW_IDEX_in(wire_MemRW),
    .WBsel_IDEX_in(wire_WBsel),
    .ImmSel_IDEX_in(wire_ImmSel),

    // control out
    .ALU_control_IDEX_out(wire_ALU_control_IDEX_out),
    .BSel_IDEX_out(wire_BSel_IDEX_out),
    .ASel_IDEX_out(wire_ASel_IDEX_out),
    .RegWEn_IDEX_out(wire_RegWEn_IDEX_out),
    .BrUn_IDEX_out(wire_BrUn_IDEX_out),
    .MemRW_IDEX_out(wire_MemRW_IDEX_out),
    .WBsel_IDEX_out(wire_WBsel_IDEX_out),
    .ImmSel_IDEX_out(wire_ImmSel_IDEX_out)


);

// intantiate EX_MEM_Register
EX_MEM_Register EX_MEM_register (
    .clk                  (clk),
    .reset                (reset),
    // data in
    .pc_EXMEM_in          (wire_pc_IDEX_out),
    .instruction_EXMEM_in (wire_instruction_IDEX_out),
    .regOut_B_EXMEM_in    (wire_regOut_B_IDEX_out),
    .ALU_result_EXMEM_in  (wire_ALU_result),

    // data out
    .pc_EXMEM_out         (wire_pc_EXMEM_out),
    .instruction_EXMEM_out(wire_instruction_EXMEM_out),
    .ALU_result_EXMEM_out (wire_ALU_result_EXMEM_out),
    .regOut_B_EXMEM_out   (wire_regOut_B_EXMEM_out),

    // control in
    .RegWEn_EXMEM_in      (wire_RegWEn_IDEX_out),
    .MemRW_EXMEM_in       (wire_MemRW_IDEX_out),
    .WBsel_EXMEM_in       (wire_WBsel_IDEX_out),

    // control out
    .RegWEn_EXMEM_out     (wire_RegWEn_EXMEM_out),
    .MemRW_EXMEM_out      (wire_MemRW_EXMEM_out),
    .WBsel_EXMEM_out      (wire_WBsel_EXMEM_out)
);


// Instantiate MEM_WB_Register
MEM_WB_Register MEM_WB_register (
    .clk                  (clk),
    .reset                (reset),
    // data in
    .instruction_MEMWB_in (wire_instruction_EXMEM_out),
    .DMEM_mux_MEMWB_in    (wire_Data_DMEM),

    //data out
    .instruction_MEMWB_out(wire_instruction_MEMWB_out),
    .DMEM_mux_MEMWB_out   (wire_Data_DMEM_WB_out),

    .RegWEn_MEMWB_out     (wire_RegWEn_MEMWB_out),
    .RegWEn_MEMWB_in      (wire_RegWEn_EXMEM_out)

);


// Instantiate controller
controller controller (
    .inst(wire_instruction_IFID_out),
    .ALU_control(wire_ALU_control),
    .PCSel(wire_PCSel),
    .ImmSel(wire_ImmSel),
    .BSel(wire_BSel),
    .ASel(wire_ASel),
    .MemRW(wire_MemRW),
    .WBSel(wire_WBsel),
    .BrEq(wire_BrEq),
    .BrUn(wire_BrUn),
    .BrLT(wire_BrLT),
    .RegWEn(wire_RegWEn)
);

// Instantiate register file
RegFile regFile (
    .read_regA(wire_instruction_IFID_out[19:15]),
    .read_regB(wire_instruction_IFID_out[24:20]),
    .write_reg(wire_instruction_MEMWB_out[11:7]),
    .write_enable(wire_RegWEn_MEMWB_out),
    .clk(clk),
    .reset(reset),
    .write_data(wire_Data_DMEM_WB_out),
    .read_dataA(wire_regOut_A),
    .read_dataB(wire_regOut_B)
);

// Instantiate main ALU
main_ALU main_ALU (
    .A(wire_A_mux_out_A),
    .B(wire_IMM_mux_out_B),
    .ALU_control(wire_ALU_control_IDEX_out),
    .ALU_result(wire_ALU_result),
    .zero(zero),
    .overflow(overflow),
    .negative(negative)
);

// Instantiate immediate generator
im_gen imm_gen (
    .data_in(wire_instruction_IDEX_out),
    .imm_sel(wire_ImmSel_IDEX_out),
    .out(wire_im_gen)
);

// Instantiate IMM mux
mux IMM_mux (
    .sel(wire_BSel_IDEX_out),
    .in0(wire_regOut_B_IDEX_out),
    .in1(wire_im_gen),
    .out(wire_IMM_mux_out_B)
);

// Instantiate data memory
DMEM DMEM (
    .clk(clk),
    .memwrite(wire_MemRW),
    .addr(wire_ALU_result_EXMEM_out),
    .data_W(wire_regOut_B_EXMEM_out),
    .data_R(wire_dataR)
);
adder pcAdderM(
    .val_in(wire_pc_EXMEM_out),
    .val_in2(32'd1),
    .val_out(wire_Next_PCm)
);
// Instantiate data memory mux
mux4_1 DMEM_mux (
    .sel(wire_WBsel_EXMEM_out),
    .in0(wire_dataR),
    .in1(wire_ALU_result_EXMEM_out),
    .in2(wire_Next_PCm),
    .out(wire_Data_DMEM)
);

// Instantiate branch comparator
Branch_comp Branch_comp (
    .A(wire_regOut_A),
    .B(wire_regOut_B),
    .BrUn(wire_BrUn),
    .BrEq(wire_BrEq),
    .BrLT(wire_BrLT)
);

// Instantiate PC final
PC_final pc (
    .clk(clk),
    .reset(reset),
    .pc_in(wire_pc_mux_out),
    .pc_out(wire_pc)
);

// Instantiate PC mux
mux pc_mux (
    .sel(wire_PCSel_IDEX_out),
    .in0(wire_pc4),
    .in1(wire_ALU_result),
    .out(wire_pc_mux_out)
);

// Instantiate PC incrementer
adder pc_incrementer (
    .val_in(wire_pc),
    .val_in2(32'd1),
    .val_out(wire_pc4)
);


mux pcBrancingMux (
    .sel(wire_ASel_IDEX_out),
    .in0(wire_regOut_A_IDEX_out),
    .in1(wire_pc_IDEX_out),
    .out(wire_A_mux_out_A)
);


endmodule
