#!/bin/bash

INCLUDES=()
INCLUDES=("${INCLUDES[@]}" "/usr/lib/gcc/x86_64-linux-gnu/4.8/include")
INCLUDES=("${INCLUDES[@]}" "/usr/local/include")
INCLUDES=("${INCLUDES[@]}" "/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed")
INCLUDES=("${INCLUDES[@]}" "/usr/include/x86_64-linux-gnu")
INCLUDES=("${INCLUDES[@]}" "/usr/include")

for (( I = 0; I < ${#INCLUDES[@]}; ++I ))
do
    cd ${INCLUDES[$I]}
    gtags -vv
done


