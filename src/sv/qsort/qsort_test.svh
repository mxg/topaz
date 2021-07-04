class qsort_test;

   function void go(int unsigned n);
      int vec[$];
      int unsigned i;

      for(i = 0; i < n; i++) begin
	 vec.push_back($urandom_range(0, 1000));
      end

      $display("--- pre-sort list ---");
      for(i = 0; i < n; i++) begin
	 $display("[%2d] %0d", i, vec[i]);
      end
      $display("--- end pre-sort list ---");
      $display("\n--- post-sort list ---");
      
      qsort_int::qsort(vec);
       
      for(i = 0; i < n; i++) begin
	 $display("[%2d] %0d", i, vec[i]);
      end
   endfunction
endclass
      
