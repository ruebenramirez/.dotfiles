#!/bin/bash

function startGraphicalXEnvironment {
    X=$(pidof X)

    if [ ${#X} == 0 ]; then
        echo 'x is not running';
        startx
    else
        echo 'x already running';
    fi;
}

startGraphicalXEnvironment
