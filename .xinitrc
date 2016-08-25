syndaemon -d -m 100 -t -k -i 2.0
export BROWSER=google-chrome &

# restart xbindkeys for the key mappings to start working
killall xbindkeys
xbindkeys

# setup trackpad config
$HOME/bin/configure-trackpad-palm-detection.sh
/usr/bin/trackpad-toggle.sh

# speed up the keyboard
xset r rate 250 60

# natural scrolling for logitech trackpad
$HOME/bin/logitech-t650-config.sh

# init display config
$HOME/bin/init-display.sh

# disable gnome window desktop background
gsettings set org.gnome.desktop.background show-desktop-icons false

# setup desktop background
feh --bg-tile /home/rramirez/.dotfiles/desktop-background/lost-background.png

# remove blues from screen when night time to help sleep at night
redshift-gtk -r &

# thinkpad power management
tlp start

# setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

exec i3
