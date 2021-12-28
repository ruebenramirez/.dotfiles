#!/usr/bin/env bash

# TODO: allow access to TCP 127.0.0.1:3389
iptables -A INPUT -p tcp -s localhost --dport 3389 -j ACCEPT


# TODO: block access to TCP *:3389
iptables -A INPUT -p tcp --dport 3389 -j DROP
