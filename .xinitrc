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

# disable optical drive eject button
bash -c 'eject -i on /dev/sr0'

# if machine is a thinkpad
sh ~/bin/setup-thinkpad.sh

# if machine is a mac
sh ~/bin/setup-mac.sh

# start network manager applet
nm-applet &

# fix gnome terminal being able to launch on XPS 15 9550
dbus-update-activation-environment --all

# fix HiDPI on XPS 15 9550
gsettings set org.gnome.desktop.interface scaling-factor 2
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export ELM_SCALE=1
xrdb -merge ~/.Xresources

exec i3
