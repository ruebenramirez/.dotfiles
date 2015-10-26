syndaemon -t -k -i 2 &
export BROWSER=google-chrome-stable &

# "THE loop"
while true
do
    # update dwm status bar
	sh .xsetroot.sh
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

if [ $(hostname -f) = "MacBookPro" ]; then
    xrandr --output eDP1 --mode 1920x1200;
fi

xscreensaver &

# init display config
/home/rramirez/bin/init-display.sh

exec dwm
