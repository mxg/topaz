virtual class strategy;
  pure virtual function void fcn();
endclass

class concrete_strategy_1 extends strategy;
  virtual function void fcn();
  endfunction
endclass

class concrete_strategy_2 extends strategy;
  virtual function void fcn();
  endfunction
endclass

class some_context#(type ST=strategy);

  ST stgy;

  function new();
    stgy = new();
  endfunction

endclass

module top;

  initial begin
    some_context#(concrete_strategy_2) ctxt;
    ctxt = new();
  end

endmodule


