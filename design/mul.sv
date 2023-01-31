// Code your design here
module mul(rs1_reg,rs2_reg,mul_rd,m_co);
  input[15:0] rs1_reg,rs2_reg;
  output reg[15:0] mul_rd,m_co;
  reg[15:0] multiplicand,multiplier,result;
  
  always@(*)begin
    multiplicand=rs1_reg;
    multiplier=rs2_reg;
    result=0;
    while(multiplicand!=0)begin
      {m_co,result}=result+multiplier;
      mul_rd=result;
      multiplicand--;
      //$display("%t mul_rd=%0d multiplicand=%0d, multiplier=%0d",$time ,rd_reg,multiplicand,multiplier);
    end
  end
endmodule
