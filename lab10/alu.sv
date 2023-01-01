module alu(
  input logic [31:0] iA,
  input logic [31:0] iB,
  input logic [2:0] iF,
  output logic [31:0] oY,
  output logic oZero
);
  
always_comb
  case(iF)
    3'b000: oY = iA & iB;
    3'b001: oY = iA | iB;
    3'b010: oY = iA + iB;
    3'b011: oY = 0;
    3'b100: oY = iA & ~iB;
    3'b101: oY = iA | ~iB;
    3'b110: oY = iA - iB;
    3'b111: oY = (iA < iB ? 32'd1 : 32'd0);
    default: oY = 0;
  endcase

  assign oZero = (oY == 0 ? 1'b1 : 1'b0);
endmodule