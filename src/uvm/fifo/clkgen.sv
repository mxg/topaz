//----------------------------------------------------------------------
// Clock Generator
//
// A simple clock generator.
//----------------------------------------------------------------------

module clkgen(output clk);

  reg r_clk;

  assign clk = r_clk;

  initial begin
    r_clk <= 0;
    forever begin
      #5;
      r_clk <= 1;
      #5;
      r_clk <= 0;
    end
  end
  
endmodule
