SHELL := /bin/bash

DIR=$(pwd)

ubuntu: update dev_packages git vim dotFiles customBins omz backlight power-management
	sudo apt-get install -qy mosh tmux flameshot xbindkeys build-essential libx11-dev libxinerama-dev sharutils suckless-tools
	# dependencies for display battery and cpu temp
	sudo apt-get install -y acpi lm-sensors
	sudo apt purge notify-osd
	sudo apt install -y i3 dunst xautolock arandr
	sudo systemctl enable multi-user.target
	sudo systemctl set-default multi-user.target

backlight:
	- sudo dpkg -i ~/.dotfiles/pkgs/light_20140713-1_i386.deb
	sudo apt-get install -f -y

save-my-eyes: customBins update
	redshift-config.sh

power-management:
	# dependencies for display battery and cpu temp
	sudo apt-get install -y tlp powertop acpi lm-sensors
	sudo tlp bat
	sudo powertop

forticlient_vpn_ubuntu: update
	sudo apt-get install -y lib32gcc1 libc6-i386
	sudo dpkg -i ./pkgs/forticlient-sslvpn_4.4.2323-1_amd64.deb

spotify_ubuntu:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get install spotify-client

update:
	- sudo apt-get update -y
	- sudo apt-get install -f -y

macbookpro_keyboard:
	echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
	echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout
	echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_opt_cmd
	xmodmap ~/.xmodmaprc

dotFiles:
	for f in .*; do test -f $$f && ln -sf "$$(pwd)/$$f" ~/$$f; done
	ln -sf $$(pwd)/.xinitrc ~/.xsessionrc
	ln -sf $$(pwd)/.i3 ~/.i3
	- unlink .i3/.i3
	ln -sf $$(pwd)/xchat-config/.xchat2 ~/.xchat2
	mkdir -p ~/.config/nvim
	ln -sf $$(pwd)/.vimrc ~/.config/nvim/init.vim

dev_packages: update ruby-dev
	- sudo apt-get install -qy git python python-pip python-dev curl xbindkeys vim vim-common git tig subversion git-svn iotop iftop htop tree nethogs jq nmap dnsutils net-tools
	- sudo pip install virtualenvwrapper autopep8

omz:
	- sudo apt-get install -y curl zsh
	- curl -L http://install.ohmyz.sh | sh
	- chsh -s /usr/bin/zsh

vim: dotFiles customBins dev_packages
	- sudo apt-get install -y vim-nox exuberant-ctags cmake python-dev fuse
	- sudo modprobe fuse
	- sudo usermod -aG fuse $$(whoami)
	- sudo pip install --upgrade neovim
	- rm -fr ~/.vim/
	- git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	- vim +PluginInstall +qall
	#- python ~/.vim/bundle/YouCompleteMe/install.py

git:
	- sudo apt-get install -y git tig
	- git config --global user.name "Rueben Ramirez"
	- git config --global user.email ruebenramirez@gmail.com
	- git config --global core.editor vim
	- git config --global color.ui true
	- git config --global --replace-all core.pager "less -F -X"

customBins:
	if [ ! -d ~/bin/ ]; then \
		mkdir ~/bin/; \
	fi
	@ln -sf $$(pwd)/bin/* ~/bin/
	- @sudo ln -sf /home/rramirez/.dotfiles/bin/trackpad-toggle.sh /usr/bin/trackpad-toggle.sh

BrotherPrinterInstall:
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

docker: update
	sudo apt install -qy docker.io
	sudo pip install docker-compose
	sudo bash -c "curl -L https://github.com/docker/machine/releases/download/v0.16.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine && \
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

install-i3-window-manager:
	#sudo bash -c 'echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list'
	sudo apt-get update
	sudo apt-get --allow-unauthenticated install sur5r-keyring
	sudo apt-get update
	sudo apt-get install i3 xautolock gnome-screensaver -qy

ruby-dev:
	rm -fr ~/.rbenv
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
	mkdir -p ~/.rbenv/plugins
	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build


sysdig:
	curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | sudo bash

install-golang:
	sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable
	sudo apt-get update
	sudo apt-get install golang

install-jenkins-taskbar:
	sudo add-apt-repository ppa:thomir/indicator-jenkins
	sudo apt-get update
	sudo apt-get install indicator-jenkins

apt-fast-setup:
	sudo bash -c "apt-get install -y aria2 git && \
		if ! [[ -f /usr/bin/apt-fast ]]; then \
		  git clone https://github.com/ilikenwf/apt-fast /tmp/apt-fast; \
		  cp /tmp/apt-fast/apt-fast /usr/bin; \
		  chmod +x /usr/bin/apt-fast; \
		  cp /tmp/apt-fast/apt-fast.conf /etc; \
		fi"
	# bash autocompletion
	sudo bash -c "cp /tmp/apt-fast/completions/bash/apt-fast /etc/bash_completion.d/ && \
		chown root:root /etc/bash_completion.d/apt-fast"
	. /etc/bash_completion
	# zsh autocompletion
	if ! [[ -f /usr/bin/zsh ]]; then \
		sudo bash -c "cp /tmp/apt-fast/completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/ && \
			chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast"; \
		source /usr/share/zsh/functions/Completion/Debian/_apt-fast; \
	fi
	# Man page installation
	sudo bash -c "cp /tmp/apt-fast/man/apt-fast.8 /usr/share/man/man8 && \
		gzip -f9 /usr/share/man/man8/apt-fast.8 && \
		cp /tmp/apt-fast/man/apt-fast.conf.5 /usr/share/man/man5 && \
		gzip -f9 /usr/share/man/man5/apt-fast.conf.5"
	# configure ubuntu apt mirrors
	sudo sed -r -i.bak "s/#MIRRORS=\( 'none' \)/MIRRORS=( 'http:\/\/mirrors.wikimedia.org\/ubuntu\/, ftp:\/\/ftp.utexas.edu\/pub\/ubuntu\/, http:\/\/mirrors.xmission.com\/ubuntu\/, http:\/\/mirrors.usinternet.com\/ubuntu\/archive\/, http:\/\/mirrors.ocf.berkeley.edu\/ubuntu\/\' )/" /etc/apt-fast.conf


oracle-java:
	sudo apt-get install -y python-software-properties
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update -y
	sudo apt-get install -y oracle-java8-installer icedtea-8-plugin

java-browser-plugin:
	sudo apt-get install icedtea-plugin

firefox-with-java-client: oracle-java java-browser-plugin
	# install Firefox v45 ESR (extended support release)
	#   which still supports NPAPI java plugin
	curl -O https://download.mozilla.org/?product=firefox-45.8.0esr-SSL&os=linux64&lang=en-US /tmp/firefox.tar.bz2
	tar -xvf /tmp/firefox.tar.bz2 -C /tmp/
	sudo mv /tmp/firefox /opt/
	# add java browser plugin to v45 ESR Firefox

xps-9550-backlight-sleep-bug-fix:
	sudo cp ./bin/97fixbacklight /lib/systemd/system-sleep/
	sudo chmod 755 /lib/systemd/system-sleep/97fixbacklight
