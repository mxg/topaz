#!/bin/bash

# Loop through all the makefiles in the tree and "make" a target for
# each.  The target is supplied on the command line.

target=$1

makefiles=`find . -name makefile -print`

errcnt=0
for f in $makefiles; do
    dir=`dirname $f`
    d=`pwd`
    cd $dir
    echo "*** make" $target "in" $dir
    make $target
    if [ $? -ne 0 ] ; then
       errcnt=$((errcnt + 1));
       errlist="$errlist $dir";
    fi
    cd $d
done

echo
echo "============================================================"
echo  $target "complete with" $errcnt "errors"
if [ $errcnt -gt 0 ] ; then
    for f in $errlist; do
	echo "   " $f
    done
fi
