module r_shift#(parameter N=16)(
  input [N-1:0] i,
  output [N-1:0] o
);
  
  assign o[N-1:0] = 1'b0;
  assign o[N-2:0] = i[N-1:1];
  
endmodule

