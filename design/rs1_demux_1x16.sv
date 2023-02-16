module rs1_demux_1x16(op_opcode,rs1_reg_val,add_rs1,sub_rs1,mul_rs1,div_rs1,and_rs1,or_rs1,xor_rs1,li_rs1);
parameter N=16;
parameter SEL=4;
  input [SEL-1:0]op_opcode;
  input [N-1:0]rs1_reg_val;
  output reg [N-1:0]add_rs1,sub_rs1,mul_rs1,div_rs1,and_rs1,or_rs1,xor_rs1,li_rs1;
  
  always@(*)begin
    if(op_opcode==0)
    add_rs1 = rs1_reg_val;
    else if(op_opcode==1)
    sub_rs1 = rs1_reg_val;
    else if(op_opcode==2)
    mul_rs1 = rs1_reg_val;
    else if(op_opcode==3)
    div_rs1 = rs1_reg_val;
    else if(op_opcode==4)
    and_rs1 = rs1_reg_val;
    else if(op_opcode==5)
    or_rs1 = rs1_reg_val;
    else if(op_opcode==6)
    xor_rs1 = rs1_reg_val;
    else if(op_opcode==7)
    li_rs1 = rs1_reg_val;
  end
  
  
endmodule
