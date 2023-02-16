module rd_demux(rd_sel,rd_val,rd_reg);
parameter N=16;
parameter SEL=4;
input [SEL-1:0]rd_sel;
input [N-1:0]rd_val;
output reg [N-1:0]rd_reg[N-1:0];

always@(*)begin
	if(rd_sel==0)
	rd_reg[0]=rd_val;
	else if(rd_sel==1)
	rd_reg[1]=rd_val;
	else if(rd_sel==2)
	rd_reg[2]=rd_val;
	else if(rd_sel==3)
	rd_reg[3]=rd_val;
	else if(rd_sel==4)
	rd_reg[4]=rd_val;
	else if(rd_sel==5)
	rd_reg[5]=rd_val;
	else if(rd_sel==6)
	rd_reg[6]=rd_val;
	else if(rd_sel==7)
	rd_reg[7]=rd_val;
	else if(rd_sel==8)
	rd_reg[8]=rd_val;
	else if(rd_sel==9)
	rd_reg[9]=rd_val;
	else if(rd_sel==10)
	rd_reg[10]=rd_val;
	else if(rd_sel==11)
	rd_reg[11]=rd_val;
	else if(rd_sel==12)
	rd_reg[12]=rd_val;
	else if(rd_sel==13)
	rd_reg[13]=rd_val;
	else if(rd_sel==14)
	rd_reg[14]=rd_val;
	else if(rd_sel==15)
	rd_reg[15]=rd_val;

//$display("rd_reg=%p",rd_reg);
end
endmodule
