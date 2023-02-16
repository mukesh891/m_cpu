module li_d(rs1_reg,rs2_reg,imm_val,li_rd);
parameter N=16;

input [N-1:0] rs1_reg,rs2_reg;
input [N-1:0]imm_val;
output reg [N-1:0] li_rd;
always@(*)begin
	li_rd = imm_val;
end
endmodule

