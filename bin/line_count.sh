#!/bin/bash

# How many lines of code are in the topaz codebase?  Produce the answer
# sans comments.

find . \( -name \*.sv -o -name \*.svh \) -print | xargs grep -v '\/\/' | wc -l

