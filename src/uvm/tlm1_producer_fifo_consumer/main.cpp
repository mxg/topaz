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

#include <iostream>

#include "verilated.h"
#include "Vtop.h"

int main(int argc, char** argv, char**) {
  const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
  contextp->threads(4);
  contextp->commandArgs(argc, argv);

  const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), ""}};

  while (VL_LIKELY(!contextp->gotFinish()))
  {
    top->eval_step();
    if (!top->eventsPending())
      break;
    contextp->time(top->nextTimeSlot());
  }

  if (VL_LIKELY(!contextp->gotFinish()))
  {
    VL_DEBUG_IF(VL_PRINTF("+ Exiting without $finish; no events left\n"););
  }

  top->final();

  contextp->statsPrintSummary();

  return 0;
}
