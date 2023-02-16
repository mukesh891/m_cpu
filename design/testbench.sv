parameter N=16;
parameter SEL=4;
`include "pc_gen.sv"

`include "rs1_mux_16x1.sv"
`include "rs2_mux_16x1.sv"

`include "rs1_demux_1x16.sv"
`include "rs2_demux_1x16.sv"

`include "add.sv"
`include "sub.sv"
`include "mul.sv"
`include "div.sv"
`include "and.sv"
`include "or.sv"
`include "xor.sv"
`include "li.sv"

`include "mux_16x1_get_rd.sv"
`include "rd_demux.sv"

typedef enum bit[N-1:0]{
  x0, //->0000
  x1,
  x2,
  x3,
  x4,
  x5,
  x6,
  x7,
  x8,
  x9,
  x10,
  x11,
  x12,
  x13,
  x14,
  x15
}reg_t;
module top;
  //ref_file
  reg [N-1:0]reg_file[N-1:0];
  reg[SEL-1:0] rd_sel;
  
  reg clk,rst;
  wire[7:0]pc;
  bit [SEL-1:0]rs1_sel;
  reg_t rs1_regname;
  //reg [N-1:0]rs1;
 
  wire [N-1:0]rs1_o;
  reg [N-1:0]opcode;
  bit [SEL-1:0]rs2_sel;
  reg_t rs2_regname;
  //reg [N-1:0]rs2;
  wire [N-1:0]rs2_o;
  
  reg_t rd_regname;
  reg[N-1:0] rd_val;
  
 
  reg [N-1:0]rs1_val;
  reg [N-1:0]rs2_val;
  
  wire[N-1:0] add_rs1,sub_rs1,add_rs2,sub_rs2,mul_rs1,mul_rs2,div_rs1,div_rs2,and_rs1,and_rs2,or_rs1,or_rs2,xor_rs1,xor_rs2,li_rs1,li_rs2;
  wire[N-1:0] add_rd_out,co,sub_rd_out,mul_rd_out,m_co,div_rd_out,rem,and_rd_out,or_rd_out,xor_rd_out,li_rd_out;

  reg [15:0]imm_val;
  
 pc pc_dut(.clk(clk),.rst(rst),.pc(pc)); 

//rs1 reg selection line  
  //rs1_mux_16x1 rs1_dut(.rs1_sel(rs1_sel),.rs1(rs1),.rs1_o(rs1_o));
  rs1_mux_16x1 rs1_dut(.rs1_sel(rs1_sel),.rs1(reg_file),.rs1_o(rs1_o));
//rs2 reg selection line  
  rs2_mux_16x1 rs2_dut(.rs2_sel(rs2_sel),.rs2(reg_file),.rs2_o(rs2_o));
  
//selected rs1 reg fed to diff design modules
  rs1_demux_1x16 rs1_demux_dut(.op_opcode(opcode[15:12]),.rs1_reg_val(rs1_val),.add_rs1(add_rs1),.sub_rs1(sub_rs1),.mul_rs1(mul_rs1),.div_rs1(div_rs1),.and_rs1(and_rs1),.or_rs1(or_rs1),.xor_rs1(xor_rs1),.li_rs1(li_rs1));
//selected rs2 reg fed to diff design modules
  rs2_demux_1x16 rs2_demux_dut(.op_opcode(opcode[15:12]),.rs2_reg_val(rs2_val),.add_rs2(add_rs2),.sub_rs2(sub_rs2),.mul_rs2(mul_rs2),.div_rs2(div_rs2),.and_rs2(and_rs2),.or_rs2(or_rs2),.xor_rs2(xor_rs2),.li_rs2(li_rs2));
/////////////////////////////// FUNDTIONAL UNITS///////////////////////////  
  //adder module port to port connection
  add add_dut(.rs1_reg(add_rs1), .rs2_reg(add_rs2), .add_rd(add_rd_out),.co(co));

  //subtracter module port to port connection
  sub sub_dut(.rs1_reg(sub_rs1), .rs2_reg(sub_rs2), .sub_rd(sub_rd_out));

  //multiplier module port to port connection
  mul mul_dut(.rs1_reg(mul_rs1), .rs2_reg(mul_rs2), .mul_rd(mul_rd_out),.m_co(m_co));

  //divider module port to port connection
  div div_dut(.rs1_reg(div_rs1), .rs2_reg(div_rs2), .div_rd(div_rd_out), .rem(rem));

  and_d and_dut(.rs1_reg(and_rs1), .rs2_reg(and_rs2),.and_rd(and_rd_out));

  or_d   or_dut(.rs1_reg(or_rs1), .rs2_reg(or_rs2),.or_rd(or_rd_out));

  xor_d xor_dut(.rs1_reg(xor_rs1), .rs2_reg(xor_rs2),.xor_rd(xor_rd_out));

  li_d li_dut(.rs1_reg(or_rs1),.rs2_reg(or_rs2),.imm_val(imm_val),.li_rd(li_rd_out));
///////////////////////////////////////////////////////////////////////////
//
//
  //rd output from all functional block is fed to 4x1 mux and o/p is selected
  //by the help of opcode selctor line
  mux_16x1_get_rd mux_16x1_get_rd_dut(.add_rd(add_rd_out),.sub_rd(sub_rd_out),.mul_rd(mul_rd_out),.div_rd(div_rd_out),.and_rd(and_rd_out),.or_rd(or_rd_out),.xor_rd(xor_rd_out),.li_rd(li_rd_out),.op_opcode(opcode[15:12]),.rd_val(rd_val));

rd_demux rd_demux_dut(.rd_sel(rd_sel),.rd_val(rd_val),.rd_reg(reg_file));

  initial begin
    @(posedge clk)
    repeat(100)begin
      {opcode,rs1_sel,rs2_sel}=$urandom;
      rs1_sel=opcode[3:0];
      rs2_sel=opcode[7:4];
      rd_sel=opcode[11:8];
      $cast(rs1_regname,rs1_sel);
      $cast(rs2_regname,rs2_sel);
      $cast(rd_regname,opcode[11:8]);
      
	rs2_val=$urandom_range(20,50);
	rs1_val=$urandom_range(20,50);
	imm_val=rs1_val;
      #5;
	/*case(opcode[13:12])
        0: begin
          reg_file[rd_sel]=rd_val;
	  if(co==0)
          $display("0x%0h \t add %0s, %0s, %0s \t %0s : 0x%0h \t rs1_val=0x%0h, rs2_val=0x%0h",pc,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rs1_val,rs2_val);
 	  else begin
	  $display("************exception case, addition result exceed data length **************"); 
          $display("0x%0h \t add %0s, %0s, %0s \t %0s : 0x%0h \t rs1_val=0x%0h, rs2_val=0x%0h",pc,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rs1_val,rs2_val);
	  $display("*****************************************************************************"); 
		end
	end
        1: begin
          reg_file[rd_sel]=rd_val;
          $display("0x%0h \t sub %0s, %0s, %0s \t %0s : 0x%0h \t rs1_val=0x%0h, rs2_val=0x%0h",pc,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rs1_val,rs2_val);
        end
        2: begin
          reg_file[rd_sel]=rd_val;
	  if(co==0)
          $display("0x%0h \t mul %0s, %0s, %0s \t %0s : 0x%0h \t rs1_val=0x%0h, rs2_val=0x%0h",pc,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rs1_val,rs2_val);
        
  	  else begin
	  $display("************exception case, addition result exceed data length **************"); 
          $display("0x%0h \t mul %0s, %0s, %0s \t %0s : 0x%0h \t rs1_val=0x%0h, rs2_val=0x%0h",pc,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rs1_val,rs2_val);
	  $display("*****************************************************************************"); 
  	end
	end
        3: begin
          reg_file[rd_sel]=rd_val;
          $display("0x%0h \t div %0s, %0s, %0s \t %0s : 0x%0h \t rs1_val=0x%0h, rs2_val=0x%0h \t rem=%0d",pc,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rs1_val,rs2_val,rem);
        end
      endcase
//$display("opcode for operation is %0b",opcode[13:12]);
      */
     case(opcode[15:12])
        0: begin
	  if(co==0)
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, add %0s, %0s, %0s \t %0s : %0d,reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,reg_file);
        	else
          $display("*0x%0h \t *****exception case, addition result exceed data length ******* rs1_val=%0d, rs2_val=%0d, add %0s, %0s, %0s \t %0s : %0d,reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,reg_file);
	end
        1: begin
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, sub %0s, %0s, %0s \t %0s : %0d,reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,reg_file);
        end
        2: begin
	  if(m_co==0)
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, mul %0s, %0s, %0s \t %0s : %0d,reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,reg_file);
        
	else
          $display("0x%0h \t ******exception case, multiplication results exceed data length ******* rs1_val=%0d, rs2_val=%0d, mul %0s, %0s, %0s \t %0s : %0d,reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,reg_file);
  	end
        3: begin
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, div %0s, %0s, %0s \t %0s : %0d,rem=%0d reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rem,reg_file);
        end
        4: begin
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, and %0s, %0s, %0s \t %0s : %0d,rem=%0d reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rem,reg_file);
        end
        5: begin
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, or %0s, %0s, %0s \t %0s : %0d,rem=%0d reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rem,reg_file);
        end
        6: begin
          $display("0x%0h \t rs1_val=%0d, rs2_val=%0d, xor %0s, %0s, %0s \t %0s : %0d,rem=%0d reg_file=%0p",pc,rs1_val,rs2_val,rd_regname.name(), rs2_regname.name(), rs1_regname.name(), rd_regname.name(),rd_val,rem,reg_file);
        end
        7: begin
          $display("0x%0h \t li %0s, %0d \t %0s : %0d,reg_file=%0p",pc,rd_regname.name(),imm_val , rd_regname.name(),rd_val,reg_file);
        end
      endcase
      //*/
      @(posedge clk);
      rs1_val=0;
      rs2_val=0;
      imm_val=0;
      
      
    
    end
  
  end
  
  initial begin
  	clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=1;
    #10 rst=0;
  end
  
  initial begin
  	#2000;
    $finish;
  end
  
  
endmodule

