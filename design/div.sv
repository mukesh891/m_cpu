// Code your design here
module div(rs1_reg,rs2_reg,div_rd,rem);
  parameter N=16;
  input[N-1:0] rs1_reg,rs2_reg;
  output reg[N-1:0] div_rd;
  reg[N-1:0] dividend,divisor,result;
  output reg[N-1:0] rem;
  always@(*)begin
    divisor=rs2_reg;
    dividend=rs1_reg;
    result=0;
    while(dividend>=divisor)begin
      dividend-=divisor;
      result++;
      div_rd=result;
      //multiplicand--;
      //$display("%t div_rd=%0d dividend=%0d, divisor=%0d",$time ,div_rd,dividend,divisor);
      
    end
    $display("div_rd=%p",div_rd);
    
    rem=dividend;
  end
endmodule
