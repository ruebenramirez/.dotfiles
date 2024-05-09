#!/usr/bin/env bash


if [[ $(sudo iptables -L -t mangle | grep 65 | wc -l) -lt 1 ]]; then
    echo 'masking network traffic'
    sudo ip6tables -t mangle -I POSTROUTING -j HL --hl-set 65
    sudo ip6tables -t mangle -I PREROUTING -j HL --hl-set 65
    sudo iptables -t mangle -I POSTROUTING -j TTL --ttl-set 65
    sudo iptables -t mangle -I PREROUTING -j TTL --ttl-set 65
    sudo iptables -L -t mangle --line-numbers
    exit 0
fi

echo 'network traffic already masked'



