Parameterized Strategy
======================

Each concrete strategy has a static interface and is not derived from
a common base class nor implements a common interface class.  The
reason is that static methods cannot be inherited in SystemVerilog.
The chosen strategy is supplied as a type parameter in the context.
The context derererences the static methods using the double colon
(::) scope operator.  No instantiation of the strategy object is
required.  Of course, the constraint is that it must be possible to
implement the strategy with static methods.