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

class logger implements logger_if;

  local string msg;
  local static logger inst;

  local function new();
  endfunction

  static function logger get_inst();
    if(inst == null)
      inst = new();
    return inst;
  endfunction

  virtual function void render(logger_if::flag_t flags, logger_if::severity_t severity,
			       int line, string file,
			       string msg_class, string msg);

    string s;
    
    if((severity == logger_if::TRACE) && !(flags & logger_if::show_trace))
      return;
    
    if((severity == logger_if::DEBUG) && !(flags & logger_if::show_debug))
      return;
    
    case(severity)
      logger_if::INFO:   s = "**INFO";
      logger_if::WARNING:s = "**WARNING";
      logger_if::ERROR:  s = "**ERROR";
      logger_if::TRACE:  s = "**TRACE";
      logger_if::DEBUG:  s = "**DEBUG";
    endcase

    s = {s, ": "};
    if(flags & logger_if::show_file)
      s = {s, file};

    if(flags & logger_if::show_line)
      s = {s, $sformatf("@%0d", line)};

    s = {s, " [", msg_class, "] ", msg};

    $display(msg);
    
   endfunction

endclass
