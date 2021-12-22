Decorator
=========

Some component imoplments an interface.  There may be occassions when
it's necessary to modify the implementation or add new funftionality
to the component.  The decorator pattern provides a means of doing
that without modifying the original component.  The decorator is also
known as a _wrapper_.

The decorator implements the same interface as the component.  As part
of the new implementation it delegates to the original component.
This ensures consistency between the component and the decorator. It
may also add new methods that are not in the original component.


