DIR=/home/rramirez/.dotfiles

all: dotFileSymlinks tmux omz vim git
	
ubuntu:
	dotFileSymlinks
	tmux
	git
	omz
	vim
	desktopAppConfigs
	customBins
	debDevPackages
	installBrotherPrinter


dotFileSymlinks:
	for f in .*; do test -f $$f && ln -sf $(DIR)/$$f ~/$$f; done
	@ln -sf $(DIR)/.xinitrc ~/.xsessionrc

tmux:
	- sudo apt-get install -y tmux
	- sudo killall tmux

omz:
	- sudo apt-get install -y zsh
	- curl -L http://install.ohmyz.sh | sh
	- chsh -s /bin/zsh

vim:
	- rm -fr ~/.vim/
	- git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	- vim +PluginInstall +qall
git:
	- sudo apt-get install -y git tig
	- git config --global user.name "Rueben Ramirez"
	- git config --global user.email ruebenramirez@gmail.com
	- git config --global core.editor vim
	- git config --global color.ui true

shutter:
	- sudo apt-get install -y libnet-dbus-glib-perl libimage-exiftool-perl libimage-info-perl shutter

xdotool:
	- sudo apt-get install -y xdotool

light:
	- sudo dpkg -i ~/.dotfiles/pkgs/light_20140713-1_i386.deb

dropboxCli:
	- sudo dpkg -i ~/.dotfiles/pkgs/dropbox_1.6.2_amd64.deb

desktopAppConfigs:
	shutter
	xdotool
	light
	dropboxCli

customBins:
	if [ ! -d ~/bin/ ]; \
	then \
		mkdir ~/bin/; \
	fi;
	@ln -sf $(DIR)/bin/* ~/bin/
	@sudo ln -sf $(DIR)/bin/trackpad-toggle.sh /usr/bin/trackpad-toggle.sh

debDevPackages:
	sudo apt-get install -y curl xbindkeys vim vim-common git tig subversion git-svn

installBrotherPrinter:
	sudo sh ~/bin/linux-brprinter-installer-2.0.0-1

adobeSourceCodeProFont:
	wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip \
		&& unzip 1.017R.zip \
		&& sudo mkdir -p /usr/share/fonts/truetype/source-code-pro \
		&& sudo cp source-code-pro-1.017R/TTF/*.ttf /usr/share/fonts/truetype/source-code-pro \
		&& rm 1.017R.zip \
		&& rm -fr source-code-pro-1.017R

screensaver:
	sudo apt-get purge gnome-screensaver
	sudo apt-get install xscreensaver

weather:
	sudo apt-get install weather

sshConfig:
	@ln -sf $(DIR)/ssh/* ~/.ssh/
	chmod 600 ~/.ssh/id_rsa
	chmod 600 ~/.ssh/id_rsa.pub
