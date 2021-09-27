module clkgen(output clk);

  reg r_clk;

  assign clk = r_clk;

  initial begin
    r_clk <= 0;
    forever begin
      #5 r_clk <= ~clk;
    end
  end
endmodule

	
module top();

  parameter DATA_WIDTH = 8;

  wire clk;
  wire ready;
  wire valid;
  wire [DATA_WIDTH-1:0] data;

  master#(.DATA_WIDTH(8)) master(.clk(clk),
				 .ready(ready),
				 .valid(valid),
				 .data(data));
  slave#(.DATA_WIDTH(8))  slave(.clk(clk),
				.ready(ready),
				.valid(valid),
				.data(data));
  clkgen ck(clk);

  initial begin
    $fsdbDumpfile("vr_ms.fsdb");
    $fsdbDumpvars();
    #500;
    $finish;
  end

endmodule
