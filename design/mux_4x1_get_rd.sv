module mux_4x1_get_rd(add_rd,sub_rd,mul_rd,div_rd,op_opcode,rd_val);
  input[15:0] add_rd,sub_rd,mul_rd,div_rd;
  input [1:0]op_opcode;
  output reg [15:0]rd_val;
  //assign rd_val=op_opcode? add_rd : sub_rd;
  always@(*)begin
    if(op_opcode==00)
      rd_val=add_rd;
    else if(op_opcode==1)
      rd_val=sub_rd;
    else if(op_opcode==2)
      rd_val=mul_rd;
    else if(op_opcode==3)
      rd_val=div_rd;
  end
endmodule
