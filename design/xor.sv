module xor_d(rs1_reg,rs2_reg,xor_rd);
parameter N=16;

input [N-1:0] rs1_reg,rs2_reg;
output reg [N-1:0] xor_rd;
always@(*)begin
	xor_rd = rs1_reg ^ rs2_reg;
end
endmodule
