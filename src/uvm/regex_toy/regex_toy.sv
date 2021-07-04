import uvm_pkg::*;
class regex_toy;
  static function void re_matcher(string regex,
                                  ref string strings[$]);
    $display("matches for regular expression : %s", regex);
    foreach(strings[i]) begin
      bit match = uvm_is_match(regex, strings[i]);
      $display("%s : %s", (match?"match":"     "), strings[i]);
    end
  endfunction
endclass

module top;

  string strings[$] = { "a.b.c",
			"abc",
			"aa.bb.cc",
			"ab.bc.cd"
			};
  string regex = "/.*c$/";

  initial begin
    regex_toy::re_matcher(regex, strings);
  end
  
endmodule

    
