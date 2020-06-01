#!/bin/bash

if [[ $(hostname -f | grep tpx1c6 | wc -l) -ge 1 ]]; then
    setxkbmap -option caps:swapescape
fi
