#!/usr/bin/env bash

# Add Tailscale’s package signing key and repository:
curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

# install tailscale:
sudo apt-get update
sudo apt-get install tailscale

# start tailscale
sudo tailscale up

# get IP addresses associated with tailscale
tailscale ip -4
tailscale ip -6



