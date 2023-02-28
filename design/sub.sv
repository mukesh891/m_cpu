module sub(rs1_reg,rs2_reg,bin,sub_rd,bo);
  parameter N=16;
<<<<<<< HEAD
  input [N-1:0]rs1_reg,rs2_reg;
  input bin;
  output reg [N-1:0]sub_rd;
  output reg bo;
  wire [N:0]b;
  genvar i;
  generate
    assign b[0]=bin;
    for(i=0; i<=N-1; i=i+1)begin
  fullsubtractor f0(.rs1_reg(rs1_reg[i]),.rs2_reg(rs2_reg[i]),.bin(b[i]),.sub_rd(sub_rd[i]),.bo(b[i+1]));
      
    end
    assign bo=b[N];
  endgenerate
=======
           input [N-1:0] rs1_reg, rs2_reg;

           output reg [N-1:0] sub_rd;
  
  always @(*) begin
	  if(rs1_reg >= rs2_reg)begin
		sub_rd = rs1_reg - rs2_reg;
end
	else
		$display("**************rs1 < rs2,exception************");
  //s = a+b+ci;
  //co = a+b+ci;  
  end
>>>>>>> 5e0e01d92687c490c43715a5d0de710529c0ff75
endmodule
//full subtractor

module fullsubtractor(rs1_reg,rs2_reg,bin,sub_rd,bo);
  input rs1_reg,rs2_reg,bin;
  output reg sub_rd,bo;
  wire b,b1,sub1;
  Half_Subtractor h1(.rs1_reg(rs1_reg),.rs2_reg(rs2_reg),.bo(b),.sub(sub1));
  Half_Subtractor h2(.rs1_reg(sub1),.rs2_reg(bin),.bo(b1),.sub(sub_rd));
  or last(bo,b1,b);
endmodule
//half subtarctor
module Half_Subtractor(input rs1_reg, rs2_reg,output reg sub, bo);
assign sub = rs1_reg ^ rs2_reg;
assign bo = ~rs1_reg & rs2_reg;
endmodule
