module imem(
  input logic [31:0] iAddr,
  output logic [31:0] oRdata
);
  
  logic [31:0] mem[31:0];
  
  initial begin
    mem[0] = 32'h016d4022;
    mem[1] = 32'h02328020;
    mem[2] = 0;
  end
  
  assign oRdata = mem[iAddr[6:2]];
endmodule