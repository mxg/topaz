Chain of Responsibility Pattern
===============================

A chain of responsibility is an ordered list of handlers.  When a
request is received each handler in the chain is interrogated to see
if it is able to handle the request.  If it is, then it processes the
request.  If not, then the next handler in the chain is interrogated.
This continues until either the request is handled or there are no
more handlers.

