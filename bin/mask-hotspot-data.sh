#!/usr/bin/env bash


if [[ $(sudo iptables -L -t mangle | grep 65 | wc -l) -lt 1 ]]; then
    echo 'configuring mask of hotspot data'
    sudo -- -c '
        ip6tables -t mangle -I POSTROUTING -j HL --hl-set 65
        ip6tables -t mangle -I PREROUTING -j HL --hl-set 65
        iptables -t mangle -I POSTROUTING -j TTL --ttl-set 65
        iptables -t mangle -I PREROUTING -j TTL --ttl-set 65
    '
    exit 0
fi

echo 'network was already configured'



