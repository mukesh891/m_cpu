module rs2_demux_1x16(op_opcode,rs2_reg_val,add_rs2,sub_rs2,mul_rs2,div_rs2,and_rs2,or_rs2,xor_rs2,li_rs2);
parameter N=16;
parameter SEL=4;

  input [SEL-1:0]op_opcode;
  input [N-1:0]rs2_reg_val;
  output reg [N-1:0]add_rs2,sub_rs2,mul_rs2,div_rs2,and_rs2,or_rs2,xor_rs2,li_rs2;
  
    always@(*)begin
  if(op_opcode==0)
    add_rs2 = rs2_reg_val;
    else if(op_opcode==1)
    sub_rs2 = rs2_reg_val;
    else if(op_opcode==2)
    mul_rs2 = rs2_reg_val;
    else if(op_opcode==3)
    div_rs2 = rs2_reg_val;
    else if(op_opcode==4)
    and_rs2 = rs2_reg_val;
    else if(op_opcode==5)
    or_rs2 = rs2_reg_val;
    else if(op_opcode==6)
    xor_rs2 = rs2_reg_val;
    else if(op_opcode==7)
    li_rs2 = rs2_reg_val;
    end
  
  
endmodule
