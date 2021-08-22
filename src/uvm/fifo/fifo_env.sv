module fifo_env();

  wire clk;
  wire rst;
  wire cs;
  wire rd_en;
  wire wr_en;
  wire [31:0] data_in;
  wire [31:0] data_out;
  wire empty;
  wire full;
   
  fifo f(
	 .clk(clk),
	 .rst(rst),
	 .cs(cs),
	 .rd_en(rd_en),
	 .wr_en(wr_en),
	 .data_in(data_in),
	 .data_out(data_out),
	 .empty(empty),
	 .full(full)
	 );

  clkgen cg(.clk(clk));

endmodule

   
