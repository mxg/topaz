Component
=========

This example demonstrates a minimal UVM testbench that contains only
one component.  The component doesn't do anything functionally.  The
component constructor is the standard constructor, using super.new()
to connect the component into the component hierarchy.  Run_test()
initiates the testbench by invoking the UVM phase mechanism.  The
argument to run_test() identifies the type name of the top-level
component in the component hierarchy.
