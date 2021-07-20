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
//------------------------------------------------------------------------------

module top;

   import abstract_factory_pkg::*;
   
   initial begin

      abstract_factory#(base) factories[3];
      base q[$];
      int unsigned i;
      int unsigned f;
      base b;
      
      factories[0] = concrete_factory#(base, class_1)::get();
      factories[1] = concrete_factory#(base, class_2)::get();
      factories[2] = concrete_factory#(base, class_3)::get();

      for(i = 0; i < 10; i++) begin
	 f = $urandom() % 3;
	 b = factories[f].create();
	 q.push_back(b);
      end

      foreach(q[i]) begin
	 $display("[%0d] %s", i, q[i].convert2string());
      end

   end

endmodule


  
