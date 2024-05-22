SHELL := /usr/bin/env bash

DIR=$(pwd)

dev-cli-packages: update
	sudo apt install -qy mosh tmux xclip build-essential sharutils keychain

desktop-packages: update backlight power-management adobeSourceCodeProFont remove-gnome-header-bar
	sudo apt install -qy flameshot xbindkeys libx11-dev libxinerama-dev suckless-tools bluez-tools blueman vlc ddcutil aria2

#ubuntu: update dev_setup git vim dotFiles customBins omz backlight power-management adobeSourceCodeProFont keychain remove-gnome-header-bar
#dev-laptop: backlight power-management adobeSourceCodeProFont keychain remove-gnome-header-bar
dev-laptop: power-management adobeSourceCodeProFont keychain
	sudo apt install -y mosh tmux flameshot xclip xbindkeys build-essential libx11-dev libxinerama-dev sharutils suckless-tools bluez-tools blueman vlc ddcutil aria2
	# dependencies for display battery and cpu temp
	sudo apt-get install -y acpi lm-sensors
	# replace default ubuntu desktop notifications with dunst for i3
	sudo apt purge notify-osd
	sudo apt install -y i3 dunst xautolock arandr feh pasystray
	# sway (i3 for wayland)
	sudo apt install -y sway waybar
	#sudo systemctl enable multi-user.target
	#sudo systemctl set-default multi-user.target
	# extra desktop apps
	sudo apt install -y rtorrent mupdf mupdf-tools light chromium flatpak alsa-utils xcalib

1password-install-flatpak:
	sudo apt install -y flatpak
	flatpak install https://downloads.1password.com/linux/flatpak/1Password.flatpakref

1password-install:
	#curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
	# echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
	# sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
	# curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
	# sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
	# curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
	sudo apt update && sudo apt install 1password -y


wsl-setup:
	# TODO: install flatpak
	# TODO: run .dotfiles
	# TODO: link up bin
	# TODO: configure nix
	# TODO: configure i3wm
	# TODO: configure fish shell

keychain:
	sudo apt install -y keychain

cli-setup: update dev_setup vim dotFiles customBins omz keychain

save-my-eyes: customBins
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

update:
	sudo apt-get update && \
		sudo apt-get upgrade -y && \
		sudo apt-get install -fy && \
		sudo apt-get autoremove -y && \
		sudo apt-get autoclean -y && \
		sudo sync && sudo sync
	sudo flatpak update -y --noninteractive
	- omz update
	- fwupdmgr get-devices
	- fwupdmgr refresh --force
	- fwupdmgr get-updates --force
	- fwupdmgr update

macbookpro_keyboard:
	/usr/bin/env python3 /home/rramirez/bin/setup-apple-keyboard.py

dotFiles:
	#- unlink ~/.Xresources
	#if [[ $$(~/bin/is-xps-17) -gt 0 ]]; then \
	#		ln -sf $$(pwd)/Xresources/.Xresources-xps-17 ~/.Xresources; \
	#	else \
	#		ln -sf $$(pwd)/Xresources/.Xresources-xps-13 ~/.Xresources; \
	#	fi;
	- ln -sf $$(pwd)/i3 ~/.config/i3
	- ln -sf $$(pwd)/fish/ ~/.config/fish
	- ln -sf $$(pwd)/alacritty/ ~/.config/alacritty

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

fish-shell: install-fish-shell configure-fish-shell

install-fish-shell:
	- sudo apt update
	- sudo apt install -y fish

configure-fish-shell:
	mkdir -p ~/.config/fish
	- ln -sf ~/.dotfiles/fish ~/.config/fish
	- chsh -s /usr/bin/fish

#vim: dotFiles customBins dev_packages
vim: dotFiles customBins
	- sudo apt-get install -y vim-nox exuberant-ctags cmake python-dev fuse
	- sudo modprobe fuse
	- sudo usermod -aG fuse $$(whoami)
	- pip3 install --upgrade yamllint
	- pip3 install black
	- rm -fr ~/.vim
	- rm -fr ~/.pyenv
	- git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	- vim +PluginInstall +qall
	- mkdir -p ~/.config/yamllint
	- cp yamllint_config.yml ~/.config/yamllint/config


vim-plugins:
	- rm -fr ~/.vim
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
	- git config --global pull.rebase true
	- git config --global --replace-all core.pager "less -F -X"
	#- git config --global --replace-all core.pager "npx git-split-diffs --color | less -RFX"
	#- git config --global --replace-all split-diffs.min-line-width 40
	#- git config --global --replace-all split-diffs.theme-name github-light

git-config:
	- git config --global user.name "Rueben Ramirez"
	- git config --global user.email ruebenramirez@gmail.com
	- git config --global core.editor vim
	- git config --global color.ui true
	- git config --global pull.rebase true
	- git config --global --replace-all core.pager "less -F -X"

customBins:
	- sudo unlink ~/bin
	- rm -fr ~/bin
	ln -sf $$(pwd)/bin ~/bin

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


docker-install-debian:
	sh ~/.dotfiles/bin/docker-install-debian.sh


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
	git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

sysdig:
	curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | sudo bash

jenkins-taskbar-install:
	sudo add-apt-repository ppa:thomir/indicator-jenkins
	sudo apt-get update
	sudo apt-get install indicator-jenkins

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

pyenv:
	rm -fr ~/.pyenv
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	cd ~/.pyenv && src/configure && make -C src
	# echo 'export PYENV_ROOT=$HOME/.pyenv' >> ~/.zshrc
	# echo 'export PATH=$PYENV_ROOT/bin:\$PATH' >> ~/.zshrc
	# echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

kubectl-install:
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
	curl -o install-nix-2.8.0 https://releases.nixos.org/nix/nix-2.8.0/install
	curl -o install-nix-2.8.0.asc https://releases.nixos.org/nix/nix-2.8.0/install.asc
	gpg2 --keyserver hkps://keyserver.ubuntu.com --recv-keys B541D55301270E0BCF15CA5D8170B4726D7198DE
	gpg2 --verify ./install-nix-2.8.0.asc
	sh ./install-nix-2.8.0
	rm ./install-nix-2.8.0 ./install-nix-2.8.0.asc

nix-uninstall:
	sudo rm -fr /nix
	- seq 1 32 | xargs -I{} bash -c 'sudo deluser "nixbld{}"'
	- sudo delgroup nixbld
	sudo rm -fr /etc/nix/
	sudo rm -fr ~/.nix*
	sudo rm -fr ~/.config/nix*

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

vagrant-install:
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	sudo apt-get update && sudo apt-get install vagrant

alacritty-install:
	sudo apt install -qy cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
	cargo install alacritty


waydroid-install:
	export DISTRO="bullseye" && \
		sudo curl https://repo.waydro.id/waydroid.gpg > /usr/share/keyrings/waydroid.gpg && \
		echo "deb [signed-by=/usr/share/keyrings/waydroid.gpg] https://repo.waydro.id/ $$DISTRO main" > /etc/apt/sources.list.d/waydroid.list && \
		sudo apt update
	sudo apt install waydroid

helmsman-install:
	curl -L https://github.com/Praqma/helmsman/releases/download/v3.8.1/helmsman_3.8.1_linux_amd64.tar.gz | tar zx
	sudo mv helmsman /usr/local/bin/helmsman

flatpak-install:
	sudo apt install flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

firefox-flatpak-install: flatpak-install
	sudo flatpak install org.mozilla.firefox

zoom-flatpak-install: flatpak-install
	wget https://dl.flathub.org/repo/appstream/us.zoom.Zoom.flatpakref
	sudo flatpak install ./us.zoom.Zoom.flatpakref

signal-private-messenger-install:
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.
	# 1. Install our official public software signing key
	wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
	cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
	# 2. Add our repository to your list of repositories
	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
	# 3. Update your package database and install signal
	sudo apt update && sudo apt install signal-desktop

r-install:
	sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
	sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
	sudo apt install -y r-base r-base-dev
	R --version

r-uninstall:
	sudo apt remove -y --purge dirmngr gnupg apt-transport-https ca-certificates software-properties-common r-base r-base-dev



# TODO: test this rule works
#
# Goal: when I connect/disconnect my bluetooth headphones, I script runs to change my PulseAudio default sink to the headphones sink
# my script is located at: ./bin/audio-config.sh
#
# udev rules directory
# /etc/udev/rules.d
#
# Current issue:
# 	- PulseAudio runs as rramirez user
# 	- udev triggers script from root user context
# 	- need to find a way to properly interface with the PulseAudio session (maybe via dbus launch?)
#
# Research on the issue:
# 	- XDG_RUNTIME_DIR env var needed: https://unix.stackexchange.com/a/602706
#	- dbus launch might help: https://askubuntu.com/questions/1322032/pactl-comands-in-sh-file-as-root#comment2252965_1322032
udev-bluetooth-headphone-audio-config:
	sudo cp udev_rules/50-bluetooth_headphones_rule.rules /etc/udev/rules.d
	sudo chown root:root /etc/udev/rules.d/50-bluetooth_headphones_rule.rules
	sudo udevadm control --reload

nix-packages:
	nix-env -iA nixpkgs.tesseract nixpkgs.scrot nixpkgs.xsel nixpkgs.hugo nixpkgs.youtube-dl

macos-faster-key-repeat:
	defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
	defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

z-install:
	mkdir -p ~/code/
	git clone git@github.com:rupa/z.git ~/code/z


fingerprint-reader-setup:
	sudo apt install -y fprintd libpam-fprintd
	fprintd-enroll $$(whoami) -f right-index-finger
	sudo pam-auth-update


sway-debian-setup:
	sudo apt install -qy sway tofi waybar wdisplays wlsunset sway-notification-center grimshot swaylock swayimg

