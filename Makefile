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
	@ln -sf $(DIR)/.ctags ~/.ctags
	@ln -sf $(DIR)/.gitconfig ~/.gitconfig
	@ln -sf $(DIR)/.tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/.vimrc ~/.vimrc
	@ln -sf $(DIR)/.xbindkeysrc ~/.xbindkeysrc
	@ln -sf $(DIR)/.xinitrc ~/.xinitrc
	@ln -sf $(DIR)/.xinitrc ~/.xsessionrc
	@ln -sf $(DIR)/.Xresources ~/.Xresources
	@ln -sf $(DIR)/.xsetroot.sh ~/.xsetroot.sh
	@ln -sf $(DIR)/.zshrc ~/.zshrc

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
	# TODO iterate through executable files in ~/.dotfiles/
	@ln -sf $(DIR)/bin/cellwifi.sh ~/bin/cellwifi.sh
	@ln -sf $(DIR)/bin/cleanupOrphans.sh ~/bin/cleanupOrphans.sh
	@ln -sf $(DIR)/bin/disablewifi.sh ~/bin/disablewifi.sh
	@ln -sf $(DIR)/bin/homessh.sh ~/bin/homessh.sh
	@ln -sf $(DIR)/bin/pingGoogle.sh ~/bin/pingGoogle.sh
	@ln -sf $(DIR)/bin/workwifi.sh ~/bin/workwifi.sh
	@ln -sf $(DIR)/bin/xWindowStart.sh ~/bin/xWindowStart.sh
	@ln -sf $(DIR)/bin/logitech-t650-config.sh ~/bin/logitech-t650-config.sh
	@sudo ln -sf $(DIR)/bin/trackpad-toggle.sh /usr/bin/trackpad-toggle.sh
	@ln -sf $(DIR)/bin/configure-trackpad-palm-detection.sh ~/bin/configure-trackpad-palm-detection.sh
	@ln -sf $(DIR)/bin/linux-brprinter-installer-2.0.0-1 ~/bin/linux-brprinter-installer-2.0.0-1
	@ln -sf $(DIR)/bin/init-display.sh ~/bin/init-display.sh
	@ln -sf $(DIR)/bin/move-mouse-left.sh ~/bin/move-mouse-left.sh
	@ln -sf $(DIR)/bin/move-mouse-right.sh ~/bin/move-mouse-right.sh
	@ln -sf $(DIR)/bin/reset-mouse-top-left-of-screen.sh ~/bin/reset-mouse-top-left-of-screen.sh

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
