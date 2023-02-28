module cpu_top
  #(
    parameter ADDR_WIDTH = 16,
    parameter DATA_WIDTH = 16,
    parameter NUM_REG = 16,
    parameter REG_WIDTH = 16
    )
   (
     //cr_if      crIf(.clk(clk),.rstn(rstn)),
     cr_if      crIf,
     read_if    instrIf,
     read_if    rdataIf,
     write_if   wdataIf
    );

 // reg clk,rstn;
  reg [DATA_WIDTH-1:0] reg_bank [NUM_REG];
  
//rs1 reg selection line  
  //rs1_mux_16x1 rs1_dut(.rs1_sel(rs1_sel),.rs1(rs1),.rs1_o(rs1_o));
  rs1_mux_16x1 rs1_dut(.rs1_sel(rs1_sel),.rs1(reg_bank),.rs1_o(rs1_o));
//rs2 reg selection line  
  rs2_mux_16x1 rs2_dut(.rs2_sel(rs2_sel),.rs2(reg_bank),.rs2_o(rs2_o));
  
//selected rs1 reg fed to diff design modules
  rs1_demux_1x4 rs1_demux_dut(.op_opcode(opcode[13:12]),.rs1_reg_val(rs1_val),.add_rs1(add_rs1),.sub_rs1(sub_rs1),.mul_rs1(mul_rs1),.div_rs1(div_rs1));
//selected rs2 reg fed to diff design modules
  rs2_demux_1x4 rs2_demux_dut(.op_opcode(opcode[13:12]),.rs2_reg_val(rs2_val),.add_rs2(add_rs2),.sub_rs2(sub_rs2),.mul_rs2(mul_rs2),.div_rs2(div_rs2));
  
  //adder module port to port connection
  add add_dut(.rs1_reg(add_rs1), .rs2_reg(add_rs2), .add_rd(add_rd_out),.co(co));

  //subtracter module port to port connection
  sub sub_dut(.rs1_reg(sub_rs1), .rs2_reg(sub_rs2), .sub_rd(sub_rd_out));

  //multiplier module port to port connection
  mul mul_dut(.rs1_reg(mul_rs1), .rs2_reg(mul_rs2), .mul_rd(mul_rd_out),.m_co(m_co));

  //divider module port to port connection
  div div_dut(.rs1_reg(div_rs1), .rs2_reg(div_rs2), .div_rd(div_rd_out), .rem(rem));
  
  //rd output from all functional block is fed to 4x1 mux and o/p is selected
  //by the help of opcode selctor line
  mux_4x1_get_rd mux_4x1_get_rd_dut(.add_rd(add_rd_out),.sub_rd(sub_rd_out),.mul_rd(mul_rd_out),.div_rd(div_rd_out),.op_opcode(opcode[13:12]),.rd_val(rd_val));

  //write back to the memory
  rd_demux rd_demux_dut(.rd_sel(rd_sel),.rd_val(rd_val),.rd_reg(reg_bank));
  
  


endmodule
