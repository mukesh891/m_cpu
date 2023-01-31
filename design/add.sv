module add(rs1_reg, rs2_reg, add_rd,co);
  parameter N=16;
  input [N-1:0] rs1_reg, rs2_reg;
  //input ci;
  output reg [N-1:0] add_rd;
  output reg [N-1:0] co;
  
  always @(*) begin;
    {co,add_rd} = rs1_reg + rs2_reg ;
    
    //if(co>0)
      //$display("*************exception***********");
//    {co , s} = a + b + ci;
    
  end
endmodule

