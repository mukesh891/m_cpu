module and_d(rs1_reg,rs2_reg,and_rd);
parameter N=16;
input [N-1:0]rs1_reg,rs2_reg;
output reg [N-1:0] and_rd;

always@(*)begin
	and_rd = rs1_reg & rs2_reg;
end

endmodule
