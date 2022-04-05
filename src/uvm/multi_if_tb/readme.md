Multi-interface Testbench
=========================

The skeleton of a multi-interface, block-level testbench.  Only the
simpolest blocks have a single interface, most devices have more than
one interface.  The testbench for a multi-interface testbench is
structured like the composition of multiple single-interface
block-level testbenches. In addition, a new function,
`get_sequencers()` provides a means to obtain more than one sequencer
from the testbench.
