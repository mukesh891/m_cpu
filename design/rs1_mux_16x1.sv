module rs1_mux_16x1(rs1_sel,rs1,rs1_o);
parameter N=16;
parameter SEL=4;

  input [SEL-1:0]rs1_sel;
  input [N-1:0]rs1[N-1:0];
  output reg[N-1:0]rs1_o;
  
  assign rs1_o=rs1[rs1_sel];
 /*input [15:0]rs1_reg0;
  input [15:0]rs1_reg1;
  input [15:0]rs1_reg2;
  input [15:0]rs1_reg3;
  input [15:0]rs1_reg4;
  input [15:0]rs1_reg5;
  input [15:0]rs1_reg6;
  input [15:0]rs1_reg7;
  input [15:0]rs1_reg8;
  input [15:0]rs1_reg9;
  input [15:0]rs1_reg10;
  input [15:0]rs1_reg11;
  input [15:0]rs1_reg12;
  input [15:0]rs1_reg13;
  input [15:0]rs1_reg14;
  input [15:0]rs1_reg15;
  output rs1_o;
  
  always@(*)begin
	  if(rs1_sel==0)
		  rs1_o=rs1_reg0;
  end
  */
  
 
  
endmodule
