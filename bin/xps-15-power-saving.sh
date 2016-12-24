#!/bin/bash

sudo bash -c "echo 'min_power' > '/sys/class/scsi_host/host1/link_power_management_policy'"
sudo bash -c "echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs'"
sudo bash -c "echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy'"
sudo bash -c "echo '1' > '/sys/module/snd_hda_intel/parameters/power_save'"
sudo bash -c "echo '0' > '/proc/sys/kernel/nmi_watchdog'"
