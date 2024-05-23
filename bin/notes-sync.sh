#!/usr/bin/env bash

set -ex

cd /home/rramirez/Documents/notes/

#git fetch --all
#git pull -r origin master
git pull --no-rebase origin master
echo "git pull complete"

NOTES_UPDATED="$(git status --porcelain | wc -l)"
if [[ "$NOTES_UPDATED" -gt 0 ]]; then
    git add .
    msg="Last Sync: $(date +"%Y-%m-%d %H:%M:%S") cron running from: $(hostname)"
    git commit -q -m "$msg"
    echo "$msg"

    echo "git push of local changes complete"
fi

git push -v origin master


