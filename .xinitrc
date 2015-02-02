
export BROWSER=google-chrome-stable &

# "THE loop"
while true
do
    # update dwm status bar
	sudo sh .xsetroot.sh
	sleep 5
done &

# restart xbindkeys for the key mappings to start working
killall xbindkeys
xbindkeys

# setup trackpad config
/home/rramirez/bin/configure-trackpad-palm-detection.sh
/usr/bin/trackpad-toggle.sh

# speed up the keyboard
xset r rate 250 60

xscreensaver &

# work display configuration
xrandr --output eDP1 --mode 1920x1200
xrandr --output HDMI2 --right-of eDP1
xrandr --output HDMI3 --above eDP1

exec dwm
