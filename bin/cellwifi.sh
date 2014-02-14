#! /bin/bash

netctl stop-all
netctl start wlp1s0-AndroidAP
/home/rramirez/bin/pingGoogle.sh
