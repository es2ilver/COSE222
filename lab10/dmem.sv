module dmem(
  input logic iClk,
  input logic iReset,
  input logic iWe,
  input logic [31:0] iAddr,
  input logic [31:0] iWdata,
  output logic [31:0] oRdata
);
  logic [31:0] mem[31:0];
  
  always_ff@(posedge iClk)
    if (iReset) begin
      mem[0] = 32'h00000000;
      mem[1] = 32'h11111111;
      mem[2] = 32'h22222222;
      mem[3] = 32'h33333333;
      mem[4] = 32'h44444444;
      mem[5] = 32'h55555555;
      mem[6] = 32'h66666666;
      mem[7] = 32'h77777777;
    end else
    if(iWe)
      mem[iAddr[6:2]] <= iWdata;
  
  assign oRdata = mem[iAddr[6:2]];
endmodule