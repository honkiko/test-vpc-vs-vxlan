#!/bin/bash
for line in `find . -maxdepth 1 -name "*.raw" -print`
do
   f=$(basename $line .raw)
   cat $line | ./qperf-parse.py > $f
done
