Registers
=========

This example demonstrates using the UVM register facility to access
registers in a DUT. The example uses a register model to represent
registers in a UVM testbench.  Those registers drive front door
accesses to the DUT. The model uses a register adapter to convert
generic transactions to bus transactions.
