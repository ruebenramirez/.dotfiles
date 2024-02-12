#!/usr/bin/env bash


# 1. Identify the Slack URL scheme and the .desktop file
URL_SCHEME="x-scheme-handler/slack"
DESKTOP_FILE=/var/lib/flatpak/app/com.slack.Slack/current/active/export/share/applications/com.slack.Slack.desktop


# 2. Check if the .desktop file exists and contains the URL scheme
grep -q "$URL_SCHEME" "$DESKTOP_FILE" && echo "Slack URL scheme is present in the .desktop file." || echo "Slack URL scheme is not present in the .desktop file."


# 3. If the URL scheme is not present, add it to the .desktop file under MimeType
# Note: You may need to use sudo to edit the .desktop file if it's in a system directory

### COMMENTED OUT FOR GOOD REASON
### --- I found that this line was already accounted for in the $DESKTOP_FILE
#echo "MimeType=$SLACK_URL_SCHEME;" | sudo tee -a "$SLACK_DESKTOP_FILE"


# 4. Use xdg-mime to set Slack as the default handler for the URL scheme
xdg-mime default "$DESKTOP_FILE" "$URL_SCHEME"
# it turns out there's a file that controls these entries: ~/.config/mimeapps.list
# the xdg-mime app manipulates this file
