#!/usr/bin/env bash

# leverage ssh-agent session without requiring interactive passphrase entry (pull passphrase from keychain)
#eval `keychain --noask --eval ~/.ssh/id_rsa`

cd /home/rramirez/Documents/notes/

#git fetch --all
git pull --no-rebase

NOTES_UPDATED="$(git status --porcelain | wc -l)"
if [[ "$NOTES_UPDATED" -gt 0 ]]; then
    git add .
    git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S") cron running from: $(hostname -f)"
fi

git push -q
