syndaemon -d -m 100 -t -k -i 2.0
export BROWSER=google-chrome &

# customize keymappings
killall xbindkeys
xbindkeys

$HOME/bin/configure-trackpad-palm-detection.sh

# faster key repeat
xset r rate 170 80

# display config
sh $HOME/bin/init-display.sh

# disable gnome window desktop background
gsettings set org.gnome.desktop.background show-desktop-icons false

# setup desktop background
feh --bg-max /home/rramirez/.dotfiles/desktop-background/guadalupe-river.jpg

# remove blues from screen when night time to help sleep at night
redshift-gtk -r &

# setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# disable optical drive eject button
bash -c 'eject -i on /dev/sr0'

# setup power saving
sudo tlp start
sh ~/bin/xps-15-power-saving.sh

# if machine is a mac
sh ~/bin/setup-mac.sh

# start network manager applet
nm-applet &

# fix gnome terminal being able to launch on XPS 15 9550
dbus-update-activation-environment --all

# fix HiDPI on XPS 15 9550
gsettings set org.gnome.desktop.interface scaling-factor 1
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export ELM_SCALE=1
xrdb -merge ~/.Xresources

# allow GTK apps to run even with wayland installed
xhost +local:

#sh $HOME/bin/pixelbook-set-res.sh

exec i3
