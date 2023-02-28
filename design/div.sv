`include "comp.sv"
`include "add.sv"
`include "sub.sv"
`include "right_shift.sv"
`include "mul.sv"

module divider#(parameter N=16)(
  input clk,
  input rstn,
  input req,
  input [N-1:0] rs1_reg,
  input [N-1:0] rs2_reg,
  output reg [N-1:0] div_rd,
  output reg [N-1:0] rem,
  output reg ready,
  output reg exception
);
  
  
  reg [N-1:0] D, d, Counter,RefCounter,refD,refd;
  bit [N-1:0] Dr;
  bit [N-1:0] temp1, temp2, temp3; 
  
  typedef enum {START, COMPARE} state;
  
  state s;
  
  bit gt, eq, lt,bin,cin;
  reg[N-1:0]m_co;
  
 comp comp_dut(
	.rs1_reg(D),
	.rs2_reg(d),
	.eq(eq),
	.gt(gt),
	.lt(lt)
);
  
  always_ff@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      s <= START;
      RefCounter <= 0;
      Counter <= 1;
      bin<=0;
    end 
    else begin
      if(s == START)begin
        //
        if(req)begin
          if(rs2_reg == 0)begin
            exception <= 1'b1;
            ready <= 1'b1;
            s <= START;  
          end else begin 
            s <= COMPARE;
            //Data
            refD <= rs1_reg;
            refd <= rs2_reg;
            D <= rs1_reg;
            d <= rs2_reg;
          end
        end else begin
          s <= START;
          ready <= 1'b0;
        end
      end else if(s == COMPARE) begin
        if(eq || gt)begin
          // rs2_reg =< rs1_reg
          D <= Dr;
          Counter <= Counter << 1;
        end else begin
          // rs2_reg > rs1_reg          
          if(Counter != 1) begin
            //RefCounter <= RefCounter + Counter;
            RefCounter <= temp3;
            Counter <= 1'b1;
            //D <= refD - refd*Counter;
            D <= temp2;
            refD <= temp2;
            end else begin 
            /// Sum of Counter values will be output.
             div_rd <= RefCounter;
	     rem <= refD;
             ready <= 1'b1;
             s <= START;
           end
        end
      end
    end
  end
  
  mul #(N) mul_d( 
  .rs1_reg(refd),
  .rs2_reg(Counter),
  .mul_rd(temp1)
);

 sub sub_d(
	.rs1_reg(refD),
	.rs2_reg(temp1),
	.bin(bin),
	.sub_rd(temp2),
	.bo(bo)
);


add add_d(
	.rs1_reg(RefCounter),
	.rs2_reg(Counter),
	.cin(cin),
	.add_rd(temp3),
	.cout(cout)
);  

 r_shift#(N) r_s_d(
  .i(D),
  .o(Dr)
);

 endmodule
