Static Factory Method
=====================

This example demonstrates an alternate implementation of the factory
method pattern. The concrete factory has a static create() method and
is not derived from an abstract factory.  SystemVerilog does not allow
static virtual methods.  By using static methods we avoid the
singleton overhead.
