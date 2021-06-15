#!/usr/bin/env bash

set -e

SWAP_SIZE=2048

sudo swapon -s
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1M count=$SWAP_SIZE
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon -s

