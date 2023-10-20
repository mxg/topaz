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
//    Copyright 2023 Mark Glasser
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

class lp_frame_l2 extends lp_frame;

  typedef lp_frame this_t;
  const local string msg_ctxt = "LP_FRAME_L2";

  rand mac_t smac;
  rand mac_t dmac;
       lp_type lptype;

  virtual function void pack();
    packer.pack(smac, LP_MAC_BITS);
    packer.pack(dmac, LP_MAC_BITS);
    packer.pack(lptype, LP_TYPE_BITS);
  endfunction
   
  virtual function void unpack();
    dmac = packer.unpack_int(LP_MAC_BITS);
    smac = packer.unpack_int(LP_MAC_BITS);
    lptype = packer.unpack_int(LP_TYPE_BITS);
  endfunction
   
  virtual function void copy(lp_frame pkt);

    this_t t;

    if(!$cast(t, pkt))
      `uvm_fatal(msg_ctxt, "cast failure")

    smac = t.smac;
    dmac = t.dmac;
    lptype = t.lptype;
     
  endfunction
   
  virtual function bit compare(lp_frame pkt);

    this_t t;
    bit  ok = 1;

    if(!$cast(t, pkt))
      `uvm_fatal(msg_ctxt, "cast failure")

    ok &= (t.smac == smac);
    ok &= (t.dmac == dmac);
    ok &= (t.lptype == lptype);
    return ok;
     
  endfunction
   
  virtual function string convert2string();
    string s;
    s = $sformatf("smac=%12x", smac);
    s = {s, $sformatf(" dmac=%12x", dmac)};
    s = {s, $sformatf(" lp_type = %4x", lptype)};
    return s;
  endfunction

endclass
   
