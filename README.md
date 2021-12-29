# topaz

Topaz is a companion to the book "Patterns and Idioms in
SystemVerilog" by Mark Glasser.  It is a library of SystemVerilog and
UVM examples.  These examples demonstrate various dersign patterns and
idioms discussed in the book.

The library is distributred under the Apache-2.0 open source license
(http://www.apache.org/licenses/LICENSE-2.0).  You are free to use the
code as you wish as long as you adhere to the terms of the license.

You can use the library by studying and running the example code.  All
of the examples can be compiled and run, though some produce no or
trivial results.

At the top of the distribution tree is a Makefile with these targets:

build -- build all the builkdable examples

run -- run all the runnable examples

clean -- clean up after build and run

list -- produce a list of all of the examples in the kit

readme -- print all the readme.me files from each example.

all -- do a clean, build, and run, in that order,

You can build and run each example individually by cd'ing to the
example directory and using make with the following targets:

build -- build the example code

run -- run the example

clean -- cleanup files created build build and run

all -- do a build and run

You are encourage to experiment with the examples -- make changes and
try variations -- in order to gain a deeper understanding of the
patterns and idioms exhibited.

All of the makefiles for the individual examples are based on the
make/makefile.common.  To make changes in how the examples are
compiled and run to fit into your local environment make changes in
makefile.common.

------------------------------------------------------------------------
 