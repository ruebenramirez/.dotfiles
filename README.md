#Rueben's Dotfiles

I'm mostly on thinkpads with NixOS + i3wm tiling window manager these days...

# Installing on a new machine:

```bash
git clone git@github.com:ruebenramirez/.dotfiles.git ~/.dotfiles
cd .dotfiles && make git-config
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/alacritty ~/.config/alacritty
ln -sf ~/.dotfiles/i3 ~/.config/i3
ln -sf ~/.dotfiles/fish ~/.config/fish
```
