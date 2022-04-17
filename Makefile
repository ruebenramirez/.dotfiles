SHELL := /bin/bash

DIR=$(pwd)

#ubuntu: update dev_setup git vim dotFiles customBins omz backlight power-management adobeSourceCodeProFont keychain remove-gnome-header-bar
ubuntu: backlight power-management adobeSourceCodeProFont keychain remove-gnome-header-bar
	sudo apt install -qy mosh tmux flameshot xclip xbindkeys build-essential libx11-dev libxinerama-dev sharutils suckless-tools bluez-tools blueman vlc ddcutil aria2
	# dependencies for display battery and cpu temp
	sudo apt-get install -y acpi lm-sensors
	# replace default ubuntu desktop notifications with dunst for i3
	sudo apt purge notify-osd
	sudo apt install -y i3 dunst xautolock arandr feh pasystray
	#sudo systemctl enable multi-user.target
	#sudo systemctl set-default multi-user.target
	# extra desktop apps
	sudo apt install -qy rtorrent mupdf mupdf-tools

snap_setup:
	sudo apt install -qy snap

slack-install: snap_setup
	sudo snap install slack --classic

authy-install: snap_setup
	sudo snap install --beta authy

keychain:
	sudo apt install keychain

cli-setup: update dev_setup vim dotFiles customBins omz keychain

backlight:
	- sudo dpkg -i ~/.dotfiles/pkgs/light_20140713-1_i386.deb
	sudo apt-get install -f -y

save-my-eyes: customBins update
	~/bin/redshift-config.sh

power-management:
	# dependencies for display battery and cpu temp
	sudo apt-get install -y tlp tlp-rdw powertop acpi lm-sensors cpufrequtils smartmontools
	sudo cpufreq-set -g powersave
	sudo cpufreq-info
	sudo systemctl enable tlp
	sudo systemctl start tlp
	sudo systemctl status tlp
	#sudo powertop

spotify_ubuntu:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get install spotify-client

update:
	sudo apt-get update && \
		sudo apt-get upgrade -y && \
		sudo apt-get install -fy && \
		sudo apt-get autoremove -y && \
		sudo apt-get autoclean -y && \
		sudo sync && sudo sync
	sudo pip install -U pip
	pip install -U pip
	nix-channel --update
	nix-env -u "*"
	- omz update
	- fwupdmgr get-devices
	- fwupdmgr refresh --force
	- fwupdmgr get-updates --force
	- fwupdmgr update

macbookpro_keyboard:
	/usr/bin/python3 /home/rramirez/bin/setup-apple-keyboard.py

dotFiles:
	for f in .*; do test -f $$f && ln -sf "$$(pwd)/$$f" ~/$$f; done

	- unlink ~/.Xresources
	if [[ $$(~/bin/is-xps-17) -gt 0 ]]; then \
			ln -sf $$(pwd)/Xresources/.Xresources-xps-17 ~/.Xresources; \
		else \
			ln -sf $$(pwd)/Xresources/.Xresources-xps-13 ~/.Xresources; \
		fi;
	ln -sf $$(pwd)/alacritty/ ~/.config/alacritty
	ln -sf $$(pwd)/.xinitrc ~/.xsessionrc
	ln -sf $$(pwd)/.i3 ~/.config/i3
	- unlink .i3/.i3
	ln -sf $$(pwd)/xchat-config/.xchat2 ~/.xchat2
	mkdir -p ~/.config/nvim
	ln -sf $$(pwd)/.vimrc ~/.config/nvim/init.vim
	ln -sf $$(pwd)/sway ~/.config

#dev_packages: update ruby-dev git pyenv go-install github-cli-install oracle-java
#dev_packages: update ruby-dev git pyenv go-install github-cli-install
dev_packages: update dev_packages_base ruby-dev git go-install github-cli-install

dev_packages_base: update ruby-dev git go-install github-cli-install
	- sudo apt-get install -qy git python python3-pip python3-dev curl xbindkeys vim vim-common subversion git-svn iotop iftop htop tree nethogs jq nmap dnsutils net-tools gnupg2 whois
	- sudo pip3 install virtualenvwrapper autopep8 click

dev_setup: dev_packages sre_stuffs

#sre_stuffs: sysdig kubectl helm-install tfenv-install aws-iam-k8s-auth helm-install azure-cli-install opa-install opa-conftest-install ansible_install
sre_stuffs: sysdig kubectl helm-install tfenv-install aws-iam-k8s-auth helm-install opa-install opa-conftest-install ansible_install

omz:
	- sudo apt-get install -y curl zsh
	- curl -L http://install.ohmyz.sh | sh
	- chsh -s /usr/bin/zsh

vim: dotFiles customBins dev_packages
	- sudo apt-get install -y vim-nox exuberant-ctags cmake python-dev fuse
	- sudo modprobe fuse
	- sudo usermod -aG fuse $$(whoami)
	- pip3 install --upgrade yamllint
	- rm -fr ~/.vim
	- rm -fr ~/.pyenv
	- git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	- vim +PluginInstall +qall
	- mkdir -p ~/.config/yamllint
	- cp yamllint_config.yml ~/.config/yamllint/config

git:
	- sudo apt-get install -y git git-lfs tig nodejs npm
	- sudo npm install -g git-split-diffs
	- git config --global user.name "Rueben Ramirez"
	- git config --global user.email ruebenramirez@gmail.com
	- git config --global core.editor vim
	- git config --global color.ui true
	#- git config --global --replace-all core.pager "less -F -X"
	- git config --global --replace-all core.pager "npx git-split-diffs --color | less -RFX"
	- git config --global --replace-all split-diffs.min-line-width 40
	- git config --global --replace-all split-diffs.theme-name github-light

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

docker:
	- sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt-get install -qy \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install -qy docker-ce docker-ce-cli containerd.io
	sudo apt install python3-pip -qy
	sudo pip3 install docker-compose
	sudo usermod -aG docker rramirez

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
	#sudo apt-get install -y python-software-properties
	sudo apt-get install -y software-properties-common
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

ansible_install:
	sudo apt update
	sudo apt install software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt install ansible

remove-gnome-header-bar:
	sudo apt install -qy gnome-tweaks
	gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

pyenv:
	rm -fr ~/.pyenv
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	cd ~/.pyenv && src/configure && make -C src
	# echo 'export PYENV_ROOT=$HOME/.pyenv' >> ~/.zshrc
	# echo 'export PATH=$PYENV_ROOT/bin:\$PATH' >> ~/.zshrc
	# echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

kubectl:
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
	echo "$(<kubectl.sha256) kubectl" | sha256sum --check
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	kubectl version --client

unetbootin-install:
	sudo add-apt-repository ppa:gezakovacs/ppa
	sudo apt-get update
	sudo apt-get install unetbootin

nix-install:
	curl -o install-nix-2.3.10 https://releases.nixos.org/nix/nix-2.3.10/install
	curl -o install-nix-2.3.10.asc https://releases.nixos.org/nix/nix-2.3.10/install.asc
	gpg2 --recv-keys B541D55301270E0BCF15CA5D8170B4726D7198DE
	gpg2 --verify ./install-nix-2.3.10.asc
	sh ./install-nix-2.3.10
	rm ./install-nix-2.3.10

tfenv-install:
	rm -fr ~/.tfenv
	git clone https://github.com/tfutils/tfenv.git ~/.tfenv
	tfenv install 0.15.0
	tfenv use 0.15.0

aws-iam-k8s-auth:
	curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator
	curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator.sha256
	openssl sha1 -sha256 aws-iam-authenticator
	chmod +x aws-iam-authenticator
	mv aws-iam-authenticator ~/bin/
	rm aws-iam-authenticator.sha256

helm-install:
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
	chmod 700 get_helm.sh
	./get_helm.sh
	rm get_helm.sh

azure-cli-install:
	sudo apt-get update
	sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
	curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
	AZ_REPO=$$(lsb_release -cs); echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $$AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
	sudo apt-get update
	sudo apt-get install azure-cli

opa-install:
	# instructions: https://www.openpolicyagent.org/docs/latest/#running-opa
	curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64
	chmod 755 opa
	sudo mv opa /usr/local/bin/

opa-conftest-install:
	# instructions: https://www.conftest.dev/install/
	wget https://github.com/open-policy-agent/conftest/releases/download/v0.24.0/conftest_0.24.0_Linux_x86_64.tar.gz
	tar xzf conftest_0.24.0_Linux_x86_64.tar.gz
	sudo mv conftest /usr/local/bin
	rm -f conftest_0.24.0_Linux_x86_64.tar.gz

go-install:
	wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz
	rm go1.18.1.linux-amd64.tar.gz

github-cli-install:
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
	sudo apt-add-repository https://cli.github.com/packages
	sudo apt update
	sudo apt install gh

test_obsidian_url:
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases | jq -r '[.[] | .assets[] | select(.name|test("AppImage")) | .browser_download_url]' | grep -v 'arm64' | jq -r '.[0]'

obsidian_setup:
	# remove old obsidian app
	sudo rm -f /usr/local/bin/Obsidian*.AppImage
	# download + install new obsidian app
	URL=$$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases | jq -r '[.[] | .assets[] | select(.name|test("AppImage")) | .browser_download_url]' | grep -v 'arm64' | jq -r '.[0]') && \
		FILE=$$(basename "$$URL") && \
		wget $$URL && \
		sudo chmod +x $$FILE && \
		sudo mv $$FILE /usr/local/bin/$$FILE
	# download notes
	NOTES="$$HOME/Documents/notes" && \
		if test ! -d $$NOTES; then git clone git@gitlab.com:ruebenramirez/notes.git $$NOTES; fi

better-zoom-background:
	# source: https://github.com/leftsidemonitor/ubuntu-zoom-virtual-background
	# install dependencies
	sudo apt-get update
	sudo apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	sudo apt install v4l2loopback-dkms;
	sudo modprobe -r v4l2loopback;
	sudo modprobe v4l2loopback devices=1 video_nr=20 card_label="v4l2loopback" exclusive_caps=1;
	# Clone
	if test ! -d $$HOME/ubuntu-zoom-virtual-background; then \
		git clone https://github.com/leftsidemonitor/ubuntu-zoom-virtual-background.git $$HOME/ubuntu-zoom-virtual-background; \
	fi
	cd $$HOME/ubuntu-zoom-virtual-background && \
		cp docker_defaults.env .env && \
		docker-compose up &;

vagrant-install:
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	sudo apt-get update && sudo apt-get install vagrant

alacritty-install:
	sudo apt install -qy cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
	cargo install alacritty

ipad-external-monitor-setup:
	# TODO: do I  want to use the gnome-session-fallback for my secondary i3wm display
	# sudo apt-get install -y tightvncserver x2x gnome-session-fallback xsel
	sudo apt install -qy tightvncserver x2x xsel gnome-session-fallback
	# password already locally set
	#vncpasswd
	# REMOVE: ipad_charge is not necessary for my setup
	# sudo apt-get install -y build-essential libusb-1.0-0 libusb-1.0-0-dev git
	# git clone https://github.com/mkorenkov/ipad_charge.git
	# cd ./ipad_charge
	# make
	# sudo make install
	# cat << EOF > ~/.vnc/xstartup
# #!/bin/sh
# xrdb $HOME/.Xresources
# xsetroot -solid grey
# #Open a terminal window in the new X display. Comment the following line if unnecessary
# x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
# x-window-manager &
# # Fix to make GNOME work
# export XKL_XMODMAP_DISABLE=1
# /etc/X11/Xsession
# EOF


waydroid-install:
	export DISTRO="bullseye" && \
		sudo curl https://repo.waydro.id/waydroid.gpg > /usr/share/keyrings/waydroid.gpg && \
		echo "deb [signed-by=/usr/share/keyrings/waydroid.gpg] https://repo.waydro.id/ $$DISTRO main" > /etc/apt/sources.list.d/waydroid.list && \
		sudo apt update
	sudo apt install waydroid

helmsman-install:
	curl -L https://github.com/Praqma/helmsman/releases/download/v3.7.7/helmsman_3.7.7_linux_amd64.tar.gz | tar zx
	sudo mv helmsman /usr/local/bin/helmsman
