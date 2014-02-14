#! /bin/bash

echo "disabling wifi";
netctl stop-all
/home/rramirez/bin/pingGoogle.sh
