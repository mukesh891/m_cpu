module xor_d(rs1_reg,rs2_reg,rd);
parameter N=16;

input [N-1:0] rs1_reg,rs2_reg;
output reg [N-1:0] rd_reg;
always@(*)begin
	rd_reg = rs1_reg xor rs2_reg;
end
endmodule