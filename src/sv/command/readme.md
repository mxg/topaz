Command Pattern
===============

In the command pattern a command object is set from an initiator to a
target where the target executes the command.  The command object is
often referred to as a transaction.

In this example the command is a DMA descriptor. An initiator is bound
to a target.  The initiator creates randomized DMA descriptors and
sends them to the target where they are processed. The class
constrained_dma_descriptor extends dma_descriptor by adding random
constraints.  The constraints force the source and destination
addresses to be aligned at 8-byte boundaries.

