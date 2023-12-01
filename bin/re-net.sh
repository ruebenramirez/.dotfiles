#!/usr/bin/env bash

echo "restarting wifi connection"
sudo systemctl stop wpa_supplicant.service
sudo systemctl start wpa_supplicant.service

echo "restarting tailscale connection"
sudo systemctl restart tailscaled.service

echo "test network connectivity"
ping google.com
