Abstract Factory Pattern
========================

An implementation of the abstract factory pattern.  In this example we
use parameterized abstract and concrete factories. We can specialize
the parameterized classes to make abstract and concrete factories for
many types.

The abstract factory class uses a class parameter to specify the
abstract product (base class).  The concrete factory class also uses a
parameter to specify the abstract product type and it uses a second
parameter to specify the concrete class type.  The
concrete_factory_singleton class is a singleton concrete factory.  The
get() method lets us get an instance of the singleton factory.
