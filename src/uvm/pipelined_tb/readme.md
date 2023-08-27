Pipelined Testbench
===================

An alternative to layering sequences to to build a pipelined
testbenches.  The technique involves creating a devices that looks
like a driver on one side and a sequencer on the other.  The driver
side connects to an upstream sequencer in the usual way.  Similarly,
the sequencer side connects to a downstream driver.  We are calling
this hybrid device a pipe stage. Pipe stages can be daisy-chained
together to create pipelines of arbitrary length.
