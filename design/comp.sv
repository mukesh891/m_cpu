/*module comp(rs1_reg,rs2_reg,comp_rd);
parameter N=16;
input [N-1:0]rs1_reg,rs2_reg;
output reg[N-1:0] comp_rd;
reg[N-1:0] a;
reg equal,greater,smaller;
genvar i;

xnor x0(n0,rs1_reg[0],rs2_reg[0]);
xnor x1(n1,rs1_reg[1],rs2_reg[1]);
xnor x2(n2,rs1_reg[2],rs2_reg[2])
xnor x3(n3,rs1_reg[3],rs2_reg[3])
xnor x4(n4,rs1_reg[4],rs2_reg[4])
xnor x5(n5,rs1_reg[5],rs2_reg[5])
xnor x6(n6,rs1_reg[6],rs2_reg[6])
xnor x7(n7,rs1_reg[7],rs2_reg[7])
xnor x8(n8,rs1_reg[8],rs2_reg[8])
xnor x9(n9,rs1_reg[9],rs2_reg[9])
xnor x10(n10,rs1_reg[10],rs2_reg[10])
xnor x11(n11,rs1_reg[11],rs2_reg[11])
xnor x12(n12,rs1_reg[12],rs2_reg[12])
xnor x13(n13,rs1_reg[13],rs2_reg[13])
xnor x14(n14,rs1_reg[14],rs2_reg[14])
xnor x15(n15,rs1_reg[15],rs2_reg[15])
and eq(equal,n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15);


xnor x0_0(n0_0,~rs1_reg[0],~rs2_reg[0]);
xnor x1(n0,rs1_reg[0],rs2_reg[0]);
xnor x1(n0,rs1_reg[0],rs2_reg[0]);
xnor x1(n0,rs1_reg[0],rs2_reg[0]);

endmodule */

module comp_1(rs1_reg,rs2_reg,eq,gt,lt);
input rs1_reg,rs2_reg;
output reg eq,gt,lt;
genvar i;


xnor x0(eq,rs1_reg,rs2_reg);
and a1(gt,rs1_reg,~rs2_reg);
and a2(lt,~rs1_reg,rs2_reg);



endmodule


module comp_4(rs1_reg,rs2_reg,eq,gt,lt);
input [3:0]rs1_reg,rs2_reg;
output reg eq,gt,lt;
wire n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,gt1,gt2,gt3,lt1,lt2,lt3,eq1;
genvar i;


comp_1 dut_0(.rs1_reg(rs1_reg[0]),.rs2_reg(rs2_reg[0]),.eq(n1),.gt(n5),.lt(n9));
comp_1 dut_1(.rs1_reg(rs1_reg[1]),.rs2_reg(rs2_reg[1]),.eq(n2),.gt(n6),.lt(n10));
comp_1 dut_2(.rs1_reg(rs1_reg[2]),.rs2_reg(rs2_reg[2]),.eq(n3),.gt(n7),.lt(n11));
comp_1 dut_3(.rs1_reg(rs1_reg[3]),.rs2_reg(rs2_reg[3]),.eq(n4),.gt(n8),.lt(n12));

//for greater than combo
and g1(gt1,n5,n2,n3,n4);
and g2(gt2,n6,n3,n4);
and g3(gt3,n7,n4);

or great1(gt,gt1,gt2,gt3,n8);

//for lesser than
and l1(lt1,n9,n2,n3,n4);
and l2(lt2,n10,n3,n4);
and l3(lt3,n11,n4);

or lesser(lt,lt1,lt2,lt3,n12);
//for equal
and eq_1(eq,n1,n2,n3,n4);
endmodule

module comp(rs1_reg,rs2_reg,eq,gt,lt);
input [15:0]rs1_reg,rs2_reg;
output reg eq,gt,lt;
wire n14,n15,n16,n17,n18,n19,n20,n21,n22,n23,n24,gt4,gt5,gt6,lt4,lt5,lt6;
genvar i;

comp_4 dut_4(.rs1_reg(rs1_reg[3:0]),.rs2_reg(rs2_reg[3:0]),.eq(n14),.gt(n18),.lt(n22));
comp_4 dut_5(.rs1_reg(rs1_reg[7:4]),.rs2_reg(rs2_reg[7:4]),.eq(n15),.gt(n19),.lt(n23));
comp_4 dut_6(.rs1_reg(rs1_reg[11:8]),.rs2_reg(rs2_reg[11:8]),.eq(n16),.gt(n20),.lt(n24));
comp_4 dut_7(.rs1_reg(rs1_reg[15:12]),.rs2_reg(rs2_reg[15:12]),.eq(n17),.gt(n21),.lt(n25));

//for greater than combo
and g4(gt4,n18,n15,n16,n17);
and g5(gt5,n19,n16,n17);
and g6(gt6,n20,n17);

or gtr(gt,gt4,gt5,gt6,n21);
//for lesser than
and l4(lt4,n22,n17,n15,n16);
and l5(lt5,n23,n17,n16);
and l6(lt6,n24,n17);

or ltn(lt,lt4,lt5,lt6,n25);

//for equal
and eq2(eq,n14,n15,n16,n17);


endmodule

/*module comp(inp1,inp2,a_less,a_greater,equal);
  //parameter N=16;
  input inp1,inp2;
  output reg a_less,a_greater,equal;
  wire t1,t2;
  
  not n1(t1,inp2);
  and a1(a_greater,t1,inp1);
  xnor x1(equal,inp1,inp2);
  not n2(t2,inp1);
  and a2(a_less,t2,inp2);
endmodule

module comp_4_bit(inp1,inp2,a_less,a_greater,equal);
  input [3:0]inp1,inp2;
  output reg a_less,a_greater,equal;
  wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12;
  wire y1,y2,y3,y4,y5,y6;
  
  comp c1(.inp1(inp1[0]),.inp2(inp2[0]),.a_less(t1),.a_greater(t2),.equal(t3));
  comp c2(.inp1(inp1[1]),.inp2(inp2[1]),.a_less(t4),.a_greater(t5),.equal(t6));
  comp c3(.inp1(inp1[2]),.inp2(inp2[2]),.a_less(t7),.a_greater(t8),.equal(t9));
  comp c4(.inp1(inp1[3]),.inp2(inp2[3]),.a_less(t10),.a_greater(t11),.equal(t12));
  
  //assign y1= t2 & t6 & t9 & t12; 
  and b1(y1,t2,t6,t9,t12);
 // assign y2= t1 & t6 & t9 & t12; 
  and b2(y2,t1,t6,t9,t12);
  //assign y3= t5 & t9 & t12;
  and b3(y3,t5,t9,t12);
  //assign y4= t4 & t9 & t12;
  and b4(y4,t4,t9,t12);
  //assign y5= t8 & t12;
  and b5(y5,t8,t12);
  //assign y6= t7 & t12;
  and b6(y6,t7,t12);
  
 // assign = 
  
 // assign equal = t3 & t6 & t9 & t12;
  and b7(equal,t3,t6,t9,t12);
  //assign a_greater= y1 | y3 | y5 |t11;
  or b8(a_greater,y1,y3,y5,t11);
 // assign a_less = y2 | y4 | y6| t10;
  or b9(a_less,y2,y4,y6,t10);
  
endmodule
 
module comp_16_bit(inp1,inp2,a_less,a_greater,equal);
  input [15:0]inp1,inp2;
  output reg a_less,a_greater,equal;
  wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12;
  wire y1,y2,y3,y4,y5,y6;
  
  comp_4_bit c1(.inp1(inp1[3:0]),.inp2(inp2[3:0]),.a_less(t1),.a_greater(t2),.equal(t3));
  comp_4_bit c2(.inp1(inp1[7:4]),.inp2(inp2[7:4]),.a_less(t4),.a_greater(t5),.equal(t6));
  comp_4_bit c3(.inp1(inp1[11:8]),.inp2(inp2[11:8]),.a_less(t7),.a_greater(t8),.equal(t9));
  comp_4_bit c4(.inp1(inp1[15:12]),.inp2(inp2[15:12]),.a_less(t10),.a_greater(t11),.equal(t12));
  
  
  //assign y1= t2 & t6 & t9 & t12; 
  and b1(y1,t2,t6,t9,t12);
 // assign y2= t1 & t6 & t9 & t12; 
  and b2(y2,t1,t6,t9,t12);
  //assign y3= t5 & t9 & t12;
  and b3(y3,t5,t9,t12);
  //assign y4= t4 & t9 & t12;
  and b4(y4,t4,t9,t12);
  //assign y5= t8 & t12;
  and b5(y5,t8,t12);
  //assign y6= t7 & t12;
  and b6(y6,t7,t12);
  
 // assign = 
  
 // assign equal = t3 & t6 & t9 & t12;
  and b7(equal,t3,t6,t9,t12);
  //assign a_greater= y1 | y3 | y5 |t11;
  or b8(a_greater,y1,y3,y5,t11);
 // assign a_less = y2 | y4 | y6| t10;
  or b9(a_less,y2,y4,y6,t10);
  
endmodule
 */
