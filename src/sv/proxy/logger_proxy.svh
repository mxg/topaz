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

class logger_proxy implements logger_if;

  local logger_if::flag_t flags;
  local logger lgr;

  function new();
    lgr = logger::get_inst();
    flags = '1;
  endfunction

  virtual function void render(logger_if::flag_t flags, logger_if::severity_t severity,
			       int line, string file,
			       string msg_class, string msg);
    lgr.render(flags, severity, line, file, msg_class, msg);
  endfunction

  function void set_show_file();
    flags |= logger_if::show_file;
  endfunction

  function void clr_show_file();
    flags &= ~logger_if::show_file;
  endfunction

  function void set_show_line();
    flags |= logger_if::show_line;
  endfunction

  function void clr_show_line();
    flags &= ~logger_if::show_line;
  endfunction

  function void set_show_trace();
    flags |= logger_if::show_trace;
  endfunction

  function void clr_show_trace();
    flags &= ~logger_if::show_trace;
  endfunction

  function void set_show_debug();
    flags |= logger_if::show_debug;
  endfunction

  function void clr_show_debug();
    flags &= ~logger_if::show_debug;
  endfunction
  
  virtual function void info(string msg_class, string msg, int line, string file);
    render(flags, logger_if::INFO, line, file, msg_class, msg);
  endfunction

  virtual function void warning(string msg_class, string msg, int line, string file);
    render(flags, logger_if::WARNING, line, file, msg_class, msg);
  endfunction
  
  virtual function void error(string msg_class, string msg, int line, string file);
    render(flags, logger_if::ERROR, line, file, msg_class, msg);
  endfunction

  virtual function void trace(string msg_class, string msg, int line, string file);
    render(flags, logger_if::TRACE, line, file, msg_class, msg);
  endfunction

  virtual function void debug(string msg_class, string msg, int line, string file);
    render(flags, logger_if::DEBUG, line, file, msg_class, msg);
  endfunction
  
endclass
