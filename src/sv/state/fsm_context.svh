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

typedef struct packed
{
  bit red;
  bit yellow;
  bit green;
 } light_t;

//------------------------------------------------------------------------------
// fsm_context
//------------------------------------------------------------------------------
class fsm_context;

  local state curr_state;
  local light_t ns_light;
  local light_t ew_light;

  state states[4];

  function new();
    state_0 s0 = new();
    state_1 s1 = new();
    state_2 s2 = new();
    state_3 s3 = new();
    states = '{s0, s1, s2, s3};
    set_curr_state(0);
  endfunction

  function state get_curr_state();
    return curr_state;
  endfunction

  function void set_curr_state(int st);
    curr_state = states[st];
  endfunction

  task run();
    $timeformat(0,0,"s",4);
    repeat(20) begin
      curr_state.next_state(this);
      print_state();
    end
  endtask

  task delay(int n);
    #(n * 1s);
  endtask

  function void set_lights(light_t ns, light_t ew);
    ns_light = ns;
    ew_light = ew;
  endfunction

  function void print_state();
    int i;
    $write("[%6t] n-s: ", $time);
    $write("%s", (ns_light.red    ? "*" : "-"));
    $write("%s", (ns_light.yellow ? "*" : "-"));
    $write("%s", (ns_light.green  ? "*" : "-"));
    $write(" e-w: ");
    $write("%s", (ew_light.red    ? "*" : "-"));
    $write("%s", (ew_light.yellow ? "*" : "-"));
    $write("%s", (ew_light.green  ? "*" : "-"));
    $display();
  endfunction

endclass