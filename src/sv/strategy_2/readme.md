Static Strategy
===============

Like the simple strategy, the static strategy has a collection of
concrete strategies, each of whch implements the interface defined in
the strategy interface class.  The chosen strategy is passed to the
context as a type parameter.  It is up to the context to instantiate
and deploy the strategy.