module rs2_mux_16x1(rs2_sel,rs2,rs2_o);
parameter N=16;
parameter SEL=4;

  input [SEL-1:0]rs2_sel;
  input [N-1:0]rs2[N-1:0];
  output [N-1:0]rs2_o;
  
  assign rs2_o=rs2[rs2_sel];
  
  
endmodule
