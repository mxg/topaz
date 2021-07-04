//------------------------------------------------------------------------------
// qsort_int
//
// sorter for integers
//------------------------------------------------------------------------------
class qsort_int;

  static function void qsort(ref int vec[$]);
    if(vec.size() == 0)
      return;
    qsort_recurse(vec, 0, vec.size() - 1);
  endfunction

  static function void qsort_recurse(ref int vec[$], input int l, input int r);
    
    int i;
    int j;
    int v;
    int t;
    
    if(r <= l)
      return;

    v = vec[r];
    i = l-1;
    j = r;

    // partition
    forever begin
       do t = vec[++i]; while(i < vec.size() && t < v);
       do t = vec[--j]; while(j >= 0         && t > v);
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
