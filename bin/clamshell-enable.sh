#!/usr/bin/env bash

set -x

# TODO: disable lidswitch

echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf
echo "HandleLidSwitchExternalPower=ignore" >> /etc/systemd/logind.conf
echo "HandleLidSwitchDocked=ignore" >> /etc/systemd/logind.conf

systemctl restart systemd-logind.service


