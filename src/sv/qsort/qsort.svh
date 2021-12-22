//------------------------------------------------------------------------------
//                 .
//               .o8
//             .o888oo  .ooooo.  oo.ooooo.   .oooo.     oooooooo
//               888   d88' `88b  888' `88b `P  )88b   d'""7d8P
//               888   888   888  888   888  .oP"888     .d8P'
//               888 . 888   888  888   888 d8(  888   .d8P'  .P
//               "888" `Y8bod8P'  888bod8P' `Y888""8o d8888888P
//                                888
//                               o888o
//
//                 T O P A Z   P A T T E R N   L I B R A R Y 
//
//    TOPAZ is a library of SystemVerilog and UVM patterns and idioms.  The
//    code is suitable for study and for copying/pasting into your own work.
//
//    Copyright 2021 Mark Glasser
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
//------------------------------------------------------------------------------

//----------------------------------------------------------------------
// qsort
//
// Implementation of quicksort.  Based on algorithm defined in
// "Algorithms in C" by Robert Sedgewick, Addison-Wesley, 1990
//----------------------------------------------------------------------
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
