#!/usr/bin/env bash

set -e

if [[ -z $TIMEZONE ]]; then
    echo "need to set TIMEZONE env var";
    exit 1;
fi

print_time() {
    timedatectl | egrep "Local time|Time zone"
}


echo "display current timezone"
print_time


printf "\nchanging timezone to: $TIMEZONE\n\n"
sudo timedatectl set-timezone $TIMEZONE


echo "display updated timezone"
print_time
