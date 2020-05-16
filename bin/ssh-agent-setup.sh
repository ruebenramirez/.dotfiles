#!/bin/bash

SSH_AGENTS_RUNNING=`ps auxf | grep -E "ssh-agent\ -s" | wc -l`

if [[ $SSH_AGENTS_RUNNING -ge 1 ]]; then
    echo "cleaning up old ssh-agent"
    ps aux | grep -E "ssh-agent\ -s" | cut -d' ' -f3 | xargs -I'{}' sudo kill -9 {}
fi

echo "launching ssh agent"
eval `ssh-agent -s`
ssh-add
