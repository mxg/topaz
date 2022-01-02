Observer Pattern
================

An implementation of the observer pattern, also know as the
publisher/subscriber pattern.  The publisher keeps a list of
subscribers.  When it want so publish information the publisher calls
notify().  Notify() traverses the list of subscribers, calling
update() on each one, passing the publisher's message via the argument
list.
