#!/usr/bin/env bash

set -ex

if [[ $(sudo iptables -L -t mangle | grep 65 | wc -l) -gt 0 ]]; then
    echo 'unmasking network traffic'
    sudo ip6tables -t mangle -D POSTROUTING -j HL --hl-set 65
    sudo ip6tables -t mangle -D PREROUTING -j HL --hl-set 65
    sudo iptables -t mangle -D POSTROUTING -j TTL --ttl-set 65
    sudo iptables -t mangle -D PREROUTING -j TTL --ttl-set 65
    sudo iptables -L -t mangle --line-numbers
    exit 0
fi

echo 'traffic was already unmasked'



