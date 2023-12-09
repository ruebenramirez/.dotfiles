syndaemon -d -m 100 -t -k -i 2.0
export BROWSER=google-chrome &

# configure keyboard
$HOME/bin/re
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


# configure alacritty as default terminal emulator for non VM machines
if [[ $(grep hypervisor /proc/cpuinfo | wc -l) -lt 1 ]]; then
    # FIXME: appears to not be working as expected
    #   environment variable is NOT available after i3 loads
    export TERMINAL=alacritty
fi;

#exec xfce4
exec i3
