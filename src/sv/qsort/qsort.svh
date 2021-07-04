//----------------------------------------------------------------------
// sorter
//
// Implementation of quicksort.  Based on algorithm defined in
// "Algorithms in C" by Robert Sedgewick, Addison-Wesley, 1990
// ----------------------------------------------------------------------
class qsort#(type T=int, type P=int);

  static function void sort(ref T vec[$]);
    if(vec.size() == 0)
      return;
    qsort_recurse(vec, 0, vec.size() - 1);
  endfunction

  static function void qsort_recurse(ref T vec[$], input int l, input int r);
    
    int i;
    int j;
    T v;
    T t;
    
    if(r <= l)
      return;

    v = vec[r];
    i = l-1;
    j = r;

    // partition
    forever begin
      do t = vec[++i]; while(i < vec.size() && P::compare(t, v) < 0);
      do t = vec[--j]; while(j >= 0         && P::compare(t, v) > 0);
      if(i >= j) break;
      
      // swap  vec[i] <--> vec[j]
      t = vec[i];
      vec[i] = vec[j];
      vec[j] = t;
    end
    
    t = vec[i];
    vec[i] = vec[r];
    vec[r] = t;
    
    qsort_recurse(vec, l, i-1);
    qsort_recurse(vec, i+1, r);
    
  endfunction
  
endclass
