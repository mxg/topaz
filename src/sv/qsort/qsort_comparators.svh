class int_comparator;

   static function int compare(int a, int b);
      if(a < b)
	 return -1;
      if(a > b)
	 return 1;
      return 0;
   endfunction

endclass

class string_comparator;

   static function int compare(string a, string b);
      if(a < b)
	 return -1;
      if(a > b)
	 return 1;
      return 0;
   endfunction

endclass

class real_comparator;

   static function int compare(real a, real b);
      if(a < b)
	 return -1;
      if(a > b)
	 return 1;
      return 0;
   endfunction

endclass


      
