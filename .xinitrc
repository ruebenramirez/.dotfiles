# autoload disk and thumb drives

export BROWSER=google-chrome-stable &

# init dropbox
#dropbox start & #is dropbox responsible for the recent machine crashes?

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
~/bin/configure-mouse-palm-detection.sh
/usr/bin/trackpad-toggle.sh

# speed up the keybaord
xset r rate 250 60
exec dwm
