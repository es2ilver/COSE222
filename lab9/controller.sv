module controller(
  input logic [5:0] iOp,
  output logic oRegWrite,
  output logic oMemWrite,
  output logic [2:0] oALUControl
);
  logic [1:0] aluop;
  
  always_comb
    case(iOp)
      6'b100011: begin
        oRegWrite = 1'b1;
        oMemWrite = 1'b0;
        aluop = 2'b00;
      end
      6'b101011: begin
        oRegWrite = 1'b0;
        oMemWrite = 1'b1;
        aluop = 2'b00;
      end
      default: begin
        oRegWrite = 1'b0;
        oMemWrite = 1'b0;
        aluop = 2'b00;
      end
    endcase
  
  always_comb
    case(aluop)
      2'b00: oALUControl = 3'b010;
      default: oALUControl = 3'b000;
    endcase
endmodule
 
  