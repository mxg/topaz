Test Hierarchy
==============

This example illustrates the structure of a UVM test.  The top-level
test component contains an environment, which contains other
components.  Each component instantiates its children.

Run_test() does not have an argument specifying the type name of the
top-level component.  It's not necessary in this case because the
default test tyope name is "test".  By not specifying a name in the
argument we are relying on the default by naming the top-level
component "test".