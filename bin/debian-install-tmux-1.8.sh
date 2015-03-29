#!/bin/bash
 
cd ~/Downloads/
wget "https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz"
tar -xf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure
make
make verify
sudo make install
 
cd ~/Downloads/
wget "http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.8/tmux-1.8.tar.gz"
tar xvfz tmux-1.8.tar.gz
cd tmux-1.8/
./configure && make
make
sudo mv /usr/bin/tmux /usr/bin/tmux.bak
sudo mv tmux /usr/bin/tmux
