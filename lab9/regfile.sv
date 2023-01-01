module regfile(
  input logic iClk,
  input logic iReset,
  input logic [4:0] iRaddr1, iRaddr2, iWaddr,
  input logic iWe,
  input logic [31:0] iWdata,
  output logic [31:0] oRdata1, oRdata2
);
  
  logic [31:0] regs[31:0];
  integer i;
  
  always_ff@(posedge iClk, posedge iReset)
    if(iReset)
      for(i=0; i<32; i=i+1)
        regs[i] <= 0;
    else if(iWe & (iWaddr!=0))
      regs[iWaddr] <= iWdata;
  
  assign oRdata1 = regs[iRaddr1];
  assign oRdata2 = regs[iRaddr2];
endmodule