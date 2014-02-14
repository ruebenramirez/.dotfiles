#! /bin/bash

netctl stop-all
netctl start wlp1s0-P1-Guest 
/home/rramirez/bin/pingGoogle.sh
