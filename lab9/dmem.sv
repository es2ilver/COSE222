module dmem(
  input logic iClk,
  input logic iWe,
  input logic [31:0] iAddr,
  input logic [31:0] iWdata,
  output logic [31:0] oRdata
);
  logic [31:0] mem[31:0];
  
  always_ff@(posedge iClk)
    if(iWe)
      mem[iAddr[6:2]] <= iWdata;
  
  assign oRdata = mem[iAddr[6:2]];
endmodule