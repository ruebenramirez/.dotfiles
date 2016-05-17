SHELL := /bin/bash
DIR=$(pwd)

ubuntu: update dev_packages omz git vim dotFiles customBins thinkpad-power-management
	# remmina preferred remote desktop client
	sudo ln -sf /usr/bin/remmina /usr/bin/rdp
	# system tray when trying to run apps on dwm that need a tray
	sudo apt-get install -y trayer
	# preferred terminal emulator
	sudo apt-get install -y terminator
	sudo apt-get install -y xbindkeys
	# shutter
	sudo apt-get install -y libnet-dbus-glib-perl libimage-exiftool-perl libimage-info-perl shutter
	# xdotool - move mouse programmatically
	sudo apt-get install -y xdotool
	sudo apt-get install -y tmux
	sudo dpkg -i ~/.dotfiles/pkgs/light_20140713-1_i386.deb
	sudo apt-get install -f -y
	# screensaver
	sudo apt-get purge -y gnome-screensaver
	sudo apt-get install -y xscreensaver
	# dwm
	sudo apt-get install build-essential libx11-dev libxinerama-dev sharutils suckless-tools
	pushd /usr/local/src &&\
		sudo wget http://dl.suckless.org/dwm/dwm-6.0.tar.gz &&\
		sudo tar xvzf dwm-6.0.tar.gz &&\
		sudo chown -R `id -u`:`id -g` dwm-6.0 &&\
		pushd /usr/local/src/dwm-6.0 &&\
		sudo make clean install &&\
		popd && popd
	sudo systemctl enable multi-user.target --force
	sudo systemctl set-default multi-user.target
	# dependencies for display battery and cpu temp
	sudo apt-get install -y acpi lm-sensors

save-my-eyes: upgrade
	sudo apt-get install -y redshift

thinkpad-power-management:
	# thinkpad power management
	sudo apt-get install -y tlp tlp-rdw tp-smapi-dkms acpi-call-dkms
	sudo tlp start

forticlient_vpn_ubuntu: update
	sudo apt-get install -y lib32gcc1 libc6-i386
	sudo dpkg -i ./pkgs/forticlient-sslvpn_4.4.2323-1_amd64.deb

spotify_ubuntu:
	pushd ~/Downloads && \
		curl -O http://repository-origin.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.0.19.106.gb8a7150f_amd64.deb && \
		sudo dpkg -i ~/Downloads/spotify-client_1.0.19.106.gb8a7150f_amd64.deb && \
		rm -f ~/Downloads/spotify-client_1.0.19.106.gb8a7150f_amd64.deb && \
		popd

update:
	sudo apt-get update -y

macbookpro_keyboard:
	if [ $$(cat /etc/hostname) = 'MacBookPro' ]; then \
		echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout; \
	fi

dotFiles:
	for f in .*; do test -f $$f && ln -sf "$$(pwd)/$$f" ~/$$f; done
	ln -sf $(DIR)/.xinitrc ~/.xsessionrc

dev_packages:
	sudo apt-get install -y curl xbindkeys vim vim-common git tig subversion git-svn iotop iftop htop tree

omz:
	- sudo apt-get install -y curl zsh
	- curl -L http://install.ohmyz.sh | sh
	- chsh -s /usr/bin/zsh

vim:
	- sudo apt-get install -y vim-nox exuberant-ctags cmake python-dev
	- rm -fr ~/.vim/
	- git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	- vim +PluginInstall +qall
	- python ~/.vim/bundle/YouCompleteMe/install.py

git:
	- sudo apt-get install -y git tig
	- git config --global user.name "Rueben Ramirez"
	- git config --global user.email ruebenramirez@gmail.com
	- git config --global core.editor vim
	- git config --global color.ui true

customBins:
	if [ ! -d ~/bin/ ]; then \
		mkdir ~/bin/; \
	fi
	@ln -sf $$(pwd)/bin/* ~/bin/
	@sudo ln -sf /home/rramirez/.dotfiles/bin/trackpad-toggle.sh /usr/bin/trackpad-toggle.sh

installBrotherPrinter:
	sudo sh ~/bin/linux-brprinter-installer-2.0.0-1

weather:
	sudo apt-get install -y weather

dropbox:
	- sudo killall dropbox
	cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
	~/.dropbox-dist/dropboxd &
	pushd ~/bin && wget "https://www.dropbox.com/download?dl=packages/dropbox.py" && popd

sshConfig:
	pushd ssh; for f in *; do ln -sf "$$(pwd)/$$f" ~/.ssh/$$f; done; popd
	chmod 600 ~/.ssh/id_rsa

yolodocker: update
	sudo apt-get purge -y docker.io
	wget -qO- https://get.docker.com/ | sh
	sudo apt-get install -y python python-pip
	sudo pip install requests
	sudo pip install docker-compose

yolodockermachine:
	sudo bash -c "curl -L https://github.com/docker/machine/releases/download/v0.5.4/docker-machine_linux-amd64 > /usr/local/bin/docker-machine && \
	  sudo chmod +x /usr/local/bin/docker-machine"

virtualenvwrapper:
	- sudo apt-get remove python-pip
	sudo easy_install pip
	- sudo pip uninstall virtualenvwrapper
	sudo pip install virtualenvwrapper
	echo "export WORKON_HOME=~/Envs"
	echo "mkdir -p $WORKON_HOME"
	echo "source /usr/local/bin/virtualenvwrapper.sh"
	echo "mkvirtualenv env_name"

adobeSourceCodeProFont:
	wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip \
		&& unzip 1.017R.zip \
		&& sudo mkdir -p /usr/share/fonts/truetype/source-code-pro \
		&& sudo cp source-code-pro-1.017R/TTF/*.ttf /usr/share/fonts/truetype/source-code-pro \
		&& rm 1.017R.zip \
		&& rm -fr source-code-pro-1.017R
