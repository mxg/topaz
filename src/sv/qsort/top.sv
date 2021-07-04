module top;

   import qsort_pkg::*;

   initial begin
      qsort_test qt = new();
      qt.go(10);
   end
endmodule
