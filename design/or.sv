module or_d(rs1_reg,rs2_reg,or_rd);
parameter N=16;

input [N-1:0] rs1_reg,rs2_reg;
output reg [N-1:0] or_rd;
always@(*)begin
	or_rd = rs1_reg | rs2_reg;
end
endmodule

