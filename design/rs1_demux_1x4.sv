module rs1_demux_1x4(op_opcode,rs1_reg_val,add_rs1,sub_rs1,mul_rs1,div_rs1);
  input [1:0]op_opcode;
  input [15:0]rs1_reg_val;
  output reg [15:0]add_rs1,sub_rs1,mul_rs1,div_rs1;
  
  always@(*)begin
    if(op_opcode==0)
    add_rs1 = rs1_reg_val;
    else if(op_opcode==1)
    sub_rs1 = rs1_reg_val;
    else if(op_opcode==2)
    mul_rs1 = rs1_reg_val;
    else if(op_opcode==3)
    div_rs1 = rs1_reg_val;
  end
  
  
endmodule
