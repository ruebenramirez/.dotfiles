#!/usr/bin/env bash

CACHE_FILE="/tmp/zfs-disk-usage-cache"
CACHE_TIMEOUT=120  # Cache for 2 minutes (120 seconds)

# Check if cache exists and is fresh
if [[ -f "$CACHE_FILE" ]] && [[ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -lt $CACHE_TIMEOUT ]]; then
    cat "$CACHE_FILE"
    exit 0
fi

# zfs root file system
root_file_system_is_zfs=$(df / | grep -c 'zroot')
if [[ root_file_system_is_zfs ]]; then
    ZROOT_USED=$(sudo zfs list -j zroot | jq -r .datasets.zroot.properties.used.value | cut -d "G" -f 1)
    ZROOT_AVAILABLE=$(sudo zfs list -j zroot | jq -r .datasets.zroot.properties.available.value | cut -d "G" -f 1)
    ZROOT_SIZE=$( echo "$ZROOT_USED + $ZROOT_AVAILABLE" | bc )
    ZROOT_USED=$( echo "$ZROOT_USED * 100 / $ZROOT_SIZE" | bc )
    RESULT="$ZROOT_USED%"
    echo "$RESULT" | tee "$CACHE_FILE"
    exit 0
fi

# root fs is not zfs
df -h / | tail -1 | awk '{print $5}'
