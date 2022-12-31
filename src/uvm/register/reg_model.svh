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
//    Copyright 2022 Mark Glasser
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

class data_reg extends uvm_reg;

  function new(string name, uvm_reg_block parent);
    super.new(name, 32, 0);
    configure(parent);
  endfunction

endclass

class addr_reg extends uvm_reg;

  function new(string name, uvm_reg_block parent);
    super.new(name, 32, 0);
    configure(parent);
  endfunction

endclass

class ctrl_status_reg extends uvm_reg;

  uvm_reg_field cmd;
  uvm_reg_field status;

  function new(string name, uvm_reg_block parent);
    super.new(name, 8, 0);
    configure(parent);
    cmd = new("cmd");
    cmd.configure(this, 2, 0, "RW", 0, 0, 0, 0, 1);
    status = new("status");
    status.configure(this, 2, 2, "RW", 0, 0, 0, 0, 1);
  endfunction

endclass

class reg_model extends uvm_reg_block;

  data_reg data;
  addr_reg addr;
  ctrl_status_reg ctrl_status;

  function new(string name);
    super.new(name, 0);
  endfunction

  function void build();
    uvm_reg_addr_t offset;

    default_map = create_map("reg_map", 0, 4, UVM_LITTLE_ENDIAN);
    data = new("data", this);
    addr = new("addr", this);
    ctrl_status = new("ctrl_status", this);

    offset = 0;
    default_map.add_reg(addr, offset, "RW");
    offset +=  addr.get_n_bytes();
    default_map.add_reg(data, offset, "RW");
    offset += data.get_n_bytes();
    default_map.add_reg(ctrl_status, offset, "RW");
  endfunction

  function void set_sequencer(uvm_sequencer_base sqr);
    reg_adapter adapter = new();
    default_map.set_sequencer(sqr, adapter);
  endfunction

endclass
