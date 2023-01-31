module sub(rs1_reg,rs2_reg,sub_rd);
  parameter N=16;
           input [N-1:0] rs1_reg, rs2_reg;

           output reg [N-1:0] sub_rd;
  
  always @(*) begin
    {sub_rd} = rs1_reg - rs2_reg ;
  //s = a+b+ci;
  //co = a+b+ci;  
  end
endmodule
