// Code your design here
`include "alu.sv"
`include "regfile.sv"
`include "imem.sv"
`include "dmem.sv"
`include "controller.sv"

module mips(
  input logic iClk,
  input logic iReset
);


  logic [31:0] ALU_ALUResultE;
  logic [31:0] ALU_ALUResultM;
  logic [31:0] ALU_ALUResultW;
  
  logic [31:0] REG_SrcAD;
  logic [31:0] REG_WriteData;
  logic [31:0] IMEM_InstF;
  logic [31:0] IMEM_InstD;
  logic [31:0] DMEM_ReadDataM;
  logic [31:0] DMEM_ReadDataW;
  logic [31:0] pc;
  
  logic [4:0] WriteRegE;
  logic [4:0] WriteRegM;
  logic [4:0] WriteRegW;

  
  logic [31:0] SrcBE;

  
  logic [31:0] Result;
  logic [15:0] SignImmD;
  logic [15:0] SignImmE;
  logic [4:0] Rt;
  logic [4:0] Rd;
  
  logic CTL_RegWrite;
  logic CTL_MemWrite;
  logic CTL_RegDst;
  
  logic CTL_ALUSrcD;
  logic CTL_ALUSrcE;
  
  logic [2:0] CTL_ALUControlD;
  logic [2:0] CTL_ALUControlE;
  
  logic CTL_MemtoRegD;
  logic CTL_MemtoRegE;
  logic CTL_MemtoRegM;
  logic CTL_MemtoRegW;

  
  assign Rt = IMEM_InstD[20:16];
  assign Rd = IMEM_InstD[15:11];
  
  assign WriteRegE = CTL_RegDst ? Rd : Rt;
  assign SignImmD = {{16{IMEM_InstD[15]}}, IMEM_InstD[15:0]};
  assign SrcBE = CTL_ALUSrcE ? SignImmE : REG_WriteData;
  assign Result = CTL_MemtoRegW ? DMEM_ReadDataW : ALU_ALUResultW;
  
  logic [31:0] REG_SrcAE;
  
  alu ALU(
    .iA		(REG_SrcAE),
    .iB		(SrcBE),
    .iF		(CTL_ALUControlE),
    .oY		(ALU_ALUResultE),
    .oZero	()
  );
  
  regfile REG(
    .iClk	(iClk),
    .iReset	(iReset),
    .iRaddr1(IMEM_InstD[25:21]),
    .iRaddr2(IMEM_InstD[20:16]),
    .iWaddr	(WriteRegE),
    .iWe	(CTL_RegWriteD),
    .iWdata	(Result),
    .oRdata1(REG_SrcAD),
    .oRdata2(REG_WriteData)
  );
  
  imem IMEM(
    .iAddr	(pc),
    .oRdata	(IMEM_InstF)
  );
  
  dmem DMEM(
    .iClk	(iClk),
    .iReset	(iReset),
    .iWe	(CTL_MemWrite),
    .iAddr	(ALU_ALUResultM),
    .iWdata	(REG_WriteDataM),
    .oRdata	(DMEM_ReadDataM)
  );
  
  controller CTL(
    .iOp		(IMEM_InstD[31:26]),
    .iFunc		(IMEM_InstD[5:0]),
    .oRegWrite	(CTL_RegWriteD),
    .oMemWrite	(CTL_MemWrite),
    .oRegDst	(CTL_RegDst),
    .oALUSrc	(CTL_ALUSrcD),
    .oMemtoReg	(CTL_MemtoRegD),
    .oALUControl(CTL_ALUControlD)
  );

  
  always_ff@(posedge iClk, posedge iReset)
    if(iReset)
      pc <= 0;
    else 
      pc <= pc + 4;

    always_ff@(posedge iClk, posedge iReset)
      if(iReset) begin
      	  IMEM_InstD <= 0;
        
          REG_SrcAE <= 0;
      	  SignImmE <= 0;
          CTL_ALUSrcE <= 0;
       	  ALU_ALUResultM <= 0;
          ALU_ALUResultW <= 0;
          DMEM_ReadDataW <= 0;
          WriteRegM <= 0;
          WriteRegW <= 0;
          CTL_ALUControlE <= 0;
          CTL_MemtoRegE <= 0;
          CTL_MemtoRegM <= 0;
          CTL_MemtoRegW <= 0;
          

        
        end else begin 
          IMEM_InstD <= IMEM_InstF;
          
          
          REG_SrcAE <= REG_SrcAD;
          SignImmE <= SignImmD;
          
		      CTL_ALUSrcE <= CTL_ALUSrcD;
          ALU_ALUResultM <= ALU_ALUResultE;
          ALU_ALUResultW <= ALU_ALUResultM;
		      DMEM_ReadDataW <= DMEM_ReadDataM;
          WriteRegM <= WriteRegE;
          WriteRegW <= WriteRegM;
          
          CTL_ALUControlE <= CTL_ALUControlD;
          
          CTL_MemtoRegE <= CTL_MemtoRegD;
          CTL_MemtoRegM <= CTL_MemtoRegE;
          CTL_MemtoRegW <= CTL_MemtoRegM;


          
        end
 

endmodule
