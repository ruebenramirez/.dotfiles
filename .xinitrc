syndaemon -d -m 100 -t -k -i 2.0
export BROWSER=google-chrome &

# customize keymappings
killall xbindkeys
xbindkeys

# config trackpad
$HOME/bin/configure-trackpad-palm-detection.sh

# faster key repeat
xset r rate 250 60

# config logitech trackpad
$HOME/bin/logitech-t650-config.sh

# display config
$HOME/bin/init-display.sh

# disable gnome window desktop background
gsettings set org.gnome.desktop.background show-desktop-icons false

# setup desktop background
feh --bg-tile /home/rramirez/.dotfiles/desktop-background/lost-background.png

# remove blues from screen when night time to help sleep at night
redshift-gtk -r &

# setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# if machine is a thinkpad
sh ~/bin/setup-thinkpad.sh

# if machine is a mac
sh ~/bin/setup-mac.sh

# start network manager applet
nm-applet &

exec i3
