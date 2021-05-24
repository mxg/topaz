virtual class strategy;
  pure virtual function void operation();
endclass

class concrete_strategy_1 extends strategy;
  virtual function void operation();
  endfunction
endclass

class concrete_strategy_2 extends strategy;
  virtual function void operation();
  endfunction
endclass

class some_context;
  strategy stgy;
endclass

module top;

  initial begin
    concrete_strategy_1 stgy1;
    some_context ctxt;

    ctxt = new();
    stgy1 = new();
    ctxt.stgy = stgy1;

  end

endmodule

    
