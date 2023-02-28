`include "cr_if.sv"
`include "read_if.sv"
`include "write_if.sv"
`include "perm_if.sv"
`include "memtop_wif.sv"
`include "cputop_wif.sv"
module top;
parameter ADDR_WIDTH=16;
parameter DATA_WIDTH=16;

  bit clk;
  bit rstn;

  always #10  clk = ~clk;

  cr_if     crIF(clk, rstn);
  read_if   instr_IF();
  read_if   rdata_IF();
  write_if  wdata_IF();
  perm_if   pIF();

  //memtop_wif mem(crIF, instr_IF, rdata_IF, wdata_IF, pIF);
  
  memtop #(ADDR_WIDTH,DATA_WIDTH) mem(
	  .crIf(crIF),
	  .r0If(instr_IF),
	  .r1If(rdata_IF),
	  .wIf(wdata_IF), 
	  .pIf(pIF)
  );

  cputop #(ADDR_WIDTH,DATA_WIDTH) cpu(
.crIf(crIF),
.instrIf(instr_IF),
.rdataIf(rdata_IF),
.wdataIf(wdata_IF)
);





  initial begin
    repeat(4)
      @(posedge clk);
    rstn = 1;
    @(posedge clk);
    //RO by instruction starting sequence
    #10us;
    $finish;
  end

  /*initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    $dumpvars(0, "cpu.vcd",	cpu.*);
    $dumpvars(0, "cpu.vcd",	mem.*);
  end*/

endmodule
