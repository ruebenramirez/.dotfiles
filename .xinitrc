syndaemon -t -k -i 2 &
export BROWSER=google-chrome &

# "THE loop"
while true
do
    # update dwm status bar
    sh .xsetroot.sh
    # protect laptop from bad shutdown when out of battery
    sh .auto-safe-shutdown.sh
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

# launch screensaver
xscreensaver &

# init display config
/home/rramirez/bin/init-display.sh

# setup desktop background
feh --bg-scale /home/rramirez/.dotfiles/desktop-background/minimalism_telephone_computer_technology_99028_1600x900.jpg

redshift -r &

tlp start

# http://dwm.suckless.org/
exec dwm
