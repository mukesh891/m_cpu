module rs2_mux_16x1(rs2_sel,rs2,rs2_o);
  input [3:0]rs2_sel;
  input [15:0]rs2[15:0];
  output rs2_o;
  
  assign rs2_o=rs2[rs2_sel];
  
  
endmodule
