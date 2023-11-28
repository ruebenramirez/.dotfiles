#!/bin/bash

cd /Users/ruebenramirez/Documents/notes/ || exit

syslog -s ">>>>>>>>>>macos-notes-sync - inside $(pwd)"

syslog -s "which git: $(which git)"
syslog -s "whoami: $(whoami)"
syslog -s "$(git status 2>&1)"

git pull --no-rebase

NOTES_UPDATED="$(git status --porcelain | wc -l)"

syslog -s ">>>>>>>>>>macos-notes-sync - updates to push $NOTES_UPDATED"
if [[ "$NOTES_UPDATED" -gt 0 ]]; then
    git add .
    git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S") cron running from: $(hostname -f)"
fi

syslog -s ">>>>>>>>>>macos-notes-sync - changes commited!  Remaining changes not committed $(git status --porcelain | wc -l)"

git push -q
