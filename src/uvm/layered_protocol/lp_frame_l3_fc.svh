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
//    Copyright 2024 Mark Glasser
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

class lp_frame_l3_fc extends lp_frame_l2;

  typedef lp_frame_l3_fc this_t;
  local const string msg_ctxt = "LP_FRAME_L3_FC";
  
  rand bit [31:0] pause_delay;

  function new();
    lptype = lp_fc;
  endfunction

  virtual function void pack();
    super.pack();
    packer.pack_field_int(pause_delay, 32);
  endfunction
   
  virtual function void unpack();
    super.unpack();
    pause_delay = packer.unpack_field_int(32);
  endfunction
   
  virtual function void copy(lp_frame pkt);

    this_t t;

    if(!$cast(t, pkt))
      `uvm_fatal(msg_ctxt, "cast failure")

    super.copy(pkt);
    pause_delay = t.pause_delay;
     
  endfunction
   
  virtual function bit compare(lp_frame pkt);

    this_t t;
    bit ok;

    if(!$cast(t, pkt))
      `uvm_fatal(msg_ctxt, "cast failure")

    ok = super.compare(pkt);
    ok &= (t.pause_delay == pause_delay);
    return ok;
     
  endfunction
   
  virtual function string convert2string();
    string s;
    s = super.convert2string();
    s = {s, $sformatf(" pause delay=%0d", pause_delay)};
    return s;
  endfunction
  
    
endclass
