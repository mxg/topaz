#!/bin/bash

# List all the examples that are available.  A directory containing an
# example is defined by having a makefile.

makefiles=`find . -name makefile -print`
cnt=0

for f in $makefiles; do
    p=`dirname $f | sed s:./::`
    echo "[$cnt]" $p;
    cnt=$(( $cnt + 1 ))
done

echo
echo "*** $cnt examples"
