#!/usr/bin/env bash


if [[ $(grep hypervisor /proc/cpuinfo | wc -l) -lt 1 ]]; then
    echo "not in a VM"
else
    echo "inside a VM
fi;
