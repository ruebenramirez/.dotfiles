#!/usr/bin/env bash

PORT_OPEN=$(nmap 104.225.219.30 -p 3389 | grep open | wc -l)

if [[ $PORT_OPEN -gt 0 ]]; then
    echo "port is open to the public internet"
    exit 1
fi


echo "TCP port 3389 is not available to the public internet"
exit 0
