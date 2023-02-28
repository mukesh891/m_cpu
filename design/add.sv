module add(rs1_reg, rs2_reg, cin, add_rd, cout);
  parameter N=16;
  input cin;
  input [N-1:0] rs1_reg,rs2_reg;
  wire [N:0]c;
  wire [N-1:0]add_rd1;
  output [N-1:0] add_rd;
output cout;
genvar i;
  generate
    for(i=0; i<=N-1; i++)begin
      assign c[0]=cin;
      full_adder fa0(.rs1_reg(rs1_reg[i]), .rs2_reg(rs2_reg[i]),.cin(c[i]), .add_rd(add_rd1[i]),.cout(c[i+1]));
  assign cout= c[N];
      assign add_rd=add_rd1;
    end
  endgenerate
endmodule

//////////////////////////////
//1bit Full Adder
/////////////////////////////
module full_adder(rs1_reg,rs2_reg,cin,add_rd, cout);
input rs1_reg,rs2_reg,cin;
output add_rd, cout;
  wire x,y,z;
  half_adder h1(.rs1_reg(rs1_reg), .rs2_reg(rs2_reg), .add_rd(x), .cout(y));
  half_adder h2(.rs1_reg(x), .rs2_reg(cin), .add_rd(add_rd), .cout(z));
or or_1(cout,z,y);
endmodule

///////////////////////////
// 1 bit Half Adder
//////////////////////////
module half_adder( rs1_reg,rs2_reg, add_rd, cout );
input rs1_reg,rs2_reg;
output add_rd, cout;
  xor xor_1 (add_rd,rs1_reg,rs2_reg);
  and and_1 (cout,rs1_reg,rs2_reg);
endmodule

