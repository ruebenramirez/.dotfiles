#! /bin/bash

netctl stop-all
netctl start wlp1s0-110volt-5G
/home/rramirez/bin/pingGoogle.sh
