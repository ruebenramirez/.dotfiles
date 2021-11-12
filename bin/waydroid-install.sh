#!/usr/bin/env bash

set -e

export DISTRO="bullseye" && \
curl https://repo.waydro.id/waydroid.gpg > /usr/share/keyrings/waydroid.gpg && \
echo "deb [signed-by=/usr/share/keyrings/waydroid.gpg] https://repo.waydro.id/ $DISTRO main" > /etc/apt/sources.list.d/waydroid.list && \
sudo apt update

#sudo waydroid init
