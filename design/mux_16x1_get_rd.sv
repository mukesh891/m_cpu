module mux_16x1_get_rd(add_rd,sub_rd,mul_rd,div_rd,and_rd,or_rd,xor_rd,li_rd,op_opcode,rd_val);
  input[15:0] add_rd,sub_rd,mul_rd,div_rd,and_rd,or_rd,xor_rd,li_rd;
  input [3:0]op_opcode;
  output reg [15:0]rd_val;
  //assign rd_val=op_opcode? add_rd : sub_rd;
  always@(*)begin
	  if(op_opcode==0)begin
      rd_val=add_rd;
	//$display("add_rd=%p",add_rd);
end
	else if(op_opcode==1)begin
      rd_val=sub_rd;
	//$display("val=%p",sub_rd);
end
      else if(op_opcode==2)begin
      rd_val=mul_rd;
	//$display("mul_val=%p",mul_rd);
end
    else if(op_opcode==3)begin
      rd_val=div_rd;
	//$display("div_val=%p",div_rd);
end
    else if(op_opcode==4)begin
      rd_val=and_rd;
	//$display("and_val=%p",and_rd);
end
    else if(op_opcode==5)begin
      rd_val=or_rd;
	//$display("or_val=%p",or_rd);
end
    else if(op_opcode==6)begin
      rd_val=xor_rd;
	//$display("xor_val=%p",xor_rd);
end
    else if(op_opcode==7)begin
      rd_val=li_rd;
	//$display("li_val=%p",li_rd);
end
  
end

endmodule
