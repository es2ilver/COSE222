module controller(
  input logic [5:0] iOp,
  input logic [5:0] iFunc,
  output logic oRegWrite,
  output logic oMemWrite,
  output logic oRegDst,
  output logic oALUSrc,
  output logic oMemtoReg,
  output logic [2:0] oALUControl
);
  logic [1:0] aluop;
  
  always_comb
    begin
      oRegWrite = 1'b0;
      oMemWrite = 1'b0;
      oRegDst = 1'b0;
      oALUSrc = 1'b0;
      oMemtoReg = 1'b0;
      aluop = 2'b00;
      case(iOp)
        6'b000000: begin oRegWrite = 1'b1; oRegDst = 1'b1; aluop = 2'b10; end // r-type
        6'b100011: begin oALUSrc = 1'b1; oRegWrite = 1'b1; oMemtoReg = 1'b0; end // lw
        6'b101011: begin oALUSrc = 1'b1; oMemWrite = 1'b1; end // sw
        default: oRegWrite = 1'b0;
      endcase
    end
  
  always_comb
    case(aluop)
      2'b00: oALUControl = 3'b010;	// add
      2'b10: case(iFunc)
        6'b100000: oALUControl = 3'b010;
        6'b100010: oALUControl = 3'b110;
        6'b100100: oALUControl = 3'b000;
        6'b100101: oALUControl = 3'b001;
        6'b101010: oALUControl = 3'b111;
        default: oALUControl = 3'b000;
      endcase
      default: oALUControl = 3'b000;
    endcase
endmodule
 
  