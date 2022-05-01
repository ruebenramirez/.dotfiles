syndaemon -d -m 100 -t -k -i 2.0
export BROWSER=google-chrome &

$HOME/bin/reio
$HOME/bin/rekey
$HOME/bin/resreen
$HOME/bin/power-save-configs.sh

# disable gnome window desktop background
gsettings set org.gnome.desktop.background show-desktop-icons false

# setup desktop background
feh --bg-max /home/rramirez/.dotfiles/desktop-background/oaxaca-te-amo.jpg

# setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# fix HiDPI
gsettings set org.gnome.desktop.interface scaling-factor 1
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export ELM_SCALE=1
xrdb -merge ~/.Xresources

# allow GTK apps to run even with wayland installed
xhost +local:

export TERMINAL=alacritty
HOSTNAME=$(hostname -f)
if [[$HOSTNAME == dev.rueb.dev]]; then
    export TERMINAL=gnome-terminal
fi;

exec i3
