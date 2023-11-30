#!/usr/bin/env bash


echo "restarting tailscale connection"
sudo systemctl restart tailscaled.service

echo "test network connectivity"
ping google.com
