Template Pattern
================

The template pattern implements an algorithm as a set of steps, each
of which is implemented as a virtual function.  The abstract template
(base class) contains the algorithm implementation and a collection of
virtual functions used in the algorithm.  Concrete templates (derived
classes) contain alternate implementations of the virtual
functions. The core algorithm is the same for the concrete templates,
just the details are different as implemented in the virtual
functions.