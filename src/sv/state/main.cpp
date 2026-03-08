#include "verilated.h"
#include "Vtop.h"

int main(int argc, char** argv, char**) {
  VerilatedContext* contextp{new VerilatedContext};
  contextp->commandArgs(argc, argv);

  Vtop* top{new Vtop{contextp, ""}};

  while(!contextp->gotFinish())
  {
    top->eval_step();
    if (!top->eventsPending())
      break;
    contextp->time(top->nextTimeSlot());
  }

  top->final();
  contextp->statsPrintSummary();

  return 0;
}
