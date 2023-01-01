module testbench_mips();
  logic clk;
  logic reset;

  mips dut(
    .iClk		(clk),
    .iReset		(reset)
  );

  always
    begin
      clk = 1; #5; clk = 0; #5;
    end

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    reset = 0; #21;
    reset = 1; #10;
    reset = 0; #20;  
    #10; $stop;
  end
endmodule 
