#!/bin/bash

if [[ $(cat /sys/devices/virtual/dmi/id/chassis_vendor | grep -i lenovo | wc -l) > 0 ]]; then
    # setup thinkpad power management
    tlp start
fi
