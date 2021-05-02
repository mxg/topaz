#!/bin/bash

# Loop through all the makefiles in the tree and "make" a target for
# each.  The target is supplied on the command line.

target=$1

makefiles=`find . -name makefile -print`

for f in $makefiles; do
    dir=`dirname $f`
    d=`pwd`
    cd $dir
    echo "*** make" $target "in" $dir
    make $target
    cd $d
done
