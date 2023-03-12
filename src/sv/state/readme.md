State
=====

The state pattern models finite state machines (FSMs).  Each state is
a separate class that share a common interface.  The context contains
the state data and operates the FSM.

This example is the classic traffic light FSM.  It models an
intersection of tw streets, one going north and south and the other
going east and west.
