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

//------------------------------------------------------------------------------
// state_0
//------------------------------------------------------------------------------
class state_0 extends state;

  int seed = 45568960;

  function new(fsm_context ctxt);
    super.new(ctxt);
  endfunction

  virtual task  next_state();
    ctxt.set_lights(3'b100, 3'b001);
    ctxt.delay($dist_poisson(seed, 30));
    ctxt.set_curr_state(1);
  endtask

endclass

//------------------------------------------------------------------------------
// state_1
//------------------------------------------------------------------------------
class state_1 extends state;

  function new(fsm_context ctxt);
    super.new(ctxt);
  endfunction

  virtual task  next_state();
    ctxt.set_lights(3'b100, 3'b010);
    ctxt.delay(3);
    ctxt.set_curr_state(2);
  endtask

endclass

//------------------------------------------------------------------------------
// state_2
//------------------------------------------------------------------------------
class state_2 extends state;

  function new(fsm_context ctxt);
    super.new(ctxt);
  endfunction

  virtual task  next_state();
    ctxt.set_lights(3'b100, 3'b100);
    ctxt.delay(1);
    ctxt.set_curr_state(3);
  endtask

endclass

//------------------------------------------------------------------------------
// state_3
//------------------------------------------------------------------------------
class state_3 extends state;

  int seed = 109934;

  function new(fsm_context ctxt);
    super.new(ctxt);
  endfunction

  virtual task  next_state();
    ctxt.set_lights(3'b001, 3'b100);
    ctxt.delay($dist_poisson(seed, 30));
    ctxt.set_curr_state(4);
  endtask

endclass

//------------------------------------------------------------------------------
// state_4
//------------------------------------------------------------------------------
class state_4 extends state;

  function new(fsm_context ctxt);
    super.new(ctxt);
  endfunction

  virtual task  next_state();
    ctxt.set_lights(3'b010, 3'b100);
    ctxt.delay(3);
    ctxt.set_curr_state(5);
  endtask

endclass

//------------------------------------------------------------------------------
// state_5
//------------------------------------------------------------------------------
class state_5 extends state;

  function new(fsm_context ctxt);
    super.new(ctxt);
  endfunction

  virtual task  next_state();
    ctxt.set_lights(3'b100, 3'b100);
    ctxt.delay(1);
    ctxt.set_curr_state(0);
  endtask

endclass
