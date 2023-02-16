/// Code your design here
module mul(rs1_reg,rs2_reg,mul_rd,m_co);
  input[15:0] rs1_reg,rs2_reg;
  output reg[15:0] mul_rd,m_co;
  reg[15:0] multiplicand,multiplier,result;
  int i;
  always@(*)begin
    multiplicand=rs2_reg;
    multiplier=rs1_reg;
    m_co=0;
    for(i = rs2_reg ;i > 0;i--)begin
	if(multiplicand>0 && m_co==0)begin
      	 {m_co,result}=result+multiplier;
      	 multiplicand--;
		if(result > 2**16 || m_co>1)begin
	    		result=0;
			$display("line 18**********exception**********");
		end
    		      //$display("%t mul_rd=%0d multiplicand=%0d, multiplier=%0d",$time ,mul_rd,multiplicand,multiplier);
    end
    else
	    result=0;
      end
      if(result<= 2**16 && m_co==0)begin
      	mul_rd=result;
	$display("mul_rd=%p",mul_rd);
end
      end
endmodule


