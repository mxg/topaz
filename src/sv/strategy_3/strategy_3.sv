class concrete_strategy_1;
  static function void fcn();
  endfunction
endclass

class concrete_strategy_2;
  static function void fcn();
  endfunction
endclass

class some_context#(type ST=concrete_strategy_1);

  function void do_something();
    ST::fcn();
  endfunction

endclass

module top;

  initial begin
    some_context#(concrete_strategy_2) ctxt;
    ctxt = new();
  end

endmodule


