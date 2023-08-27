Simple Strategy
===============

Strategies can be changed by assigning a new concrete strategy object
to strategy attribute of the context.  Each concrete strategy
implements the interface defined in the strategy interface class.
The application instantiates the context and the concrete strategy of
choice.  It then assigns the strategy to the context.
