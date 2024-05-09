#!/usr/bin/env bash

set -ex

echo 'dynamically source $NOTES_DIR from $NOTES_ENV_FILE'
# This is necessary because my notes are checked out into
#   different directories on different machines:
#   - NixOS: ~/Documents/notes,
#   - WSL2: /mnt/d/Documents/notes/
#   - Termux: ~/storage/shared/notes-ssh/
NOTES_ENV_FILE=~/.notes-env
if [[ -z "$NOTES_ENV_FILE" ]]; then
    echo "We're missing a $NOTES_ENV_FILE file"
    exit 1
fi
source $NOTES_ENV_FILE
cd $NOTES_DIR

#git fetch --all
#git pull -r origin master
git pull --no-rebase origin master
echo "git pull complete"

# sync local working copy changes to the remote repo
NOTES_UPDATED="$(git status --porcelain | wc -l)"
if [[ "$NOTES_UPDATED" -gt 0 ]]; then
    echo "local working copy changes being synced to remote repo"
    GIT_COMMIT_MSG="Last Sync: $(date +"%Y-%m-%d %H:%M:%S") cron running from: $(hostname -f)"
    git add .
    git commit -q -m "$GIT_COMMIT_MSG"
fi

git push origin/master
echo "local notes synced to repo remote"
