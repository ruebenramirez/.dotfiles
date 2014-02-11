DIR=/home/rramirez/.dotfiles

all: symlinks

symlinks:
	@ln -sf $(DIR)/.ctags ~/.ctags
	@ln -sf $(DIR)/.gitconfig ~/.gitconfig
	@ln -sf $(DIR)/.tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/.vimrc ~/.vimrc
	@ln -sf $(DIR)/.xbindkeysrc ~/.xbindkeysrc
	@ln -sf $(DIR)/.xinitrc ~/.xinitrc
	@ln -sf $(DIR)/.Xresources ~/.Xresources
	@ln -sf $(DIR)/.xsetroot.sh ~/.xsetroot.sh
	@ln -sf $(DIR)/.zshrc ~/.zshrc
