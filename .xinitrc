export BROWSER=google-chrome-stable &

# "THE loop"
while true
do
    # update dwm status bar
	sudo sh .xsetroot.sh
	sleep 10s
done &

# restart xbindkeys for the key mappings to start working
pkill -f xbindkeys
xbindkeys

# setup trackpad config
~/bin/configure-trackpad-palm-detection.sh
/usr/bin/trackpad-toggle.sh

# speed up the keybaord
xset r rate 250 60
exec dwm
