#!/usr/bin/env bash

set -e;

if ! pgrep -f obsidian >/dev/null; then
    echo "Launching obsidian..."
    swaymsg "workspace 3; exec obsidian"
fi

if ! pgrep -f ssdnodes >/dev/null; then
    echo "Launching mosh to ssdnodes..."
    swaymsg "workspace 4; exec mosh ssdnodes-ubuntu-ipv4"
fi


if ! pgrep -f w520 >/dev/null; then
    echo "Launching mosh to w520..."
    swaymsg "workspace 4; exec mosh w520-debian-ipv4"
fi

if ! pgrep -f ssdnodes >/dev/null; then
    echo "Launching mosh to ssdnodes..."
    swaymsg "workspace 4; exec mosh ssdnodes-ubuntu-ipv4"
fi

if ! pgrep -f remmina >/dev/null; then
    echo "Launching remmina..."
    swaymsg "workspace 5; exec remmina &"
fi

if ! pgrep -f 1password >/dev/null; then
    echo "Launching 1password..."
    swaymsg "workspace 7; exec 1password &"
fi

if ! pgrep -f betterbird >/dev/null; then
    echo "Launching betterbird..."
    swaymsg "workspace 8; exec betterbird &"
fi

if ! pgrep -f brave >/dev/null; then
    echo "Launching brave...";
    swaymsg "workspace 9; exec brave &"
    swaymsg "workspace 10; exec brave --new-window https://voice.google.com &"
fi

if ! pgrep -f slack >/dev/null; then
    echo "Launching slack..."
    swaymsg "workspace 10; exec slack &"
fi

if ! pgrep -f Signal >/dev/null; then
    echo "Launching Signal..."
    swaymsg "workspace 10; exec Signal &"
fi

if ! pgrep -f element-desktop >/dev/null; then
    echo "Launching element-desktop..."
    swaymsg "workspace 10; exec element-desktop &"
fi
