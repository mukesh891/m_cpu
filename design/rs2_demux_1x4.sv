module rs2_demux_1x4(op_opcode,rs2_reg_val,add_rs2,sub_rs2,mul_rs2,div_rs2);
  input [1:0]op_opcode;
  input [15:0]rs2_reg_val;
  output reg [15:0]add_rs2,sub_rs2,mul_rs2,div_rs2;
  
    always@(*)begin
  if(op_opcode==0)
    add_rs2 = rs2_reg_val;
    else if(op_opcode==1)
    sub_rs2 = rs2_reg_val;
    else if(op_opcode==2)
    mul_rs2 = rs2_reg_val;
    else if(op_opcode==3)
    div_rs2 = rs2_reg_val;
    end
  
  
endmodule
