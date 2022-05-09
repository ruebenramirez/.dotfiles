#!/usr/bin/env bash

set +x

# export XDG_RUNTIME_DIR=/run/user/1000

# echo "setting variables"
# SINKS=$(sudo -H -u rramirez bash -c 'pactl list short sinks')
# BLUETOOTH_HEADPHONES_SINK='api.bluez5.a2dp.sink.WH-1000XM4'
# LAPTOP_AUDIO_SINK='alsa_output.pci-0000:00:1f.3-platform-skl_hda_dsp_generic.HiFi: hw:sofhdadsp: sink'
# logger "checking if bluetooth headphones are connected"
# echo "checking if bluetooth headphones are connected"
# if [[ $(echo "$SINKS" | grep "$BLUETOOTH_HEADPHONES_SINK" | wc -l) -gt 0 ]]; then
#     echo 'headphones found: configuring for use'
#     logger 'headphones found: configuring for use'
#     sudo -H -u rramirez bash -c 'pactl set-default-sink "$BLUETOOTH_HEADPHONES_SINK"'
# else
#     echo 'no headphones found: using laptop speakers or wired headphones'
#     logger 'no headphones found: using laptop speakers or wired headphones'
#     sudo -H -u rramirez bash -c 'pactl set-default-sink "$LAPTOP_AUDIO_SINK"'
# fi


echo "setting variables"
SINKS=$(pactl list short sinks)
BLUETOOTH_HEADPHONES_SINK='api.bluez5.a2dp.sink.WH-1000XM4'
LAPTOP_AUDIO_SINK='alsa_output.pci-0000:00:1f.3-platform-skl_hda_dsp_generic.HiFi: hw:sofhdadsp: sink'
logger "checking if bluetooth headphones are connected"
echo "checking if bluetooth headphones are connected"
if [[ $(echo "$SINKS" | grep "$BLUETOOTH_HEADPHONES_SINK" | wc -l) -gt 0 ]]; then
    echo 'headphones found: configuring for use'
    logger 'headphones found: configuring for use'
    pactl set-default-sink "$BLUETOOTH_HEADPHONES_SINK"
else
    echo 'no headphones found: using laptop speakers or wired headphones'
    logger 'no headphones found: using laptop speakers or wired headphones'
    pactl set-default-sink "$LAPTOP_AUDIO_SINK"
fi
