Factory Method
==============

The abstract creator class provides the factory_method interface. One
or more concrete creators implement the factory method.  The factory
method uses a selector to choose which concrete type to create. In
this example the selector it an enum, however, it can by any type that
makes sense for the application.