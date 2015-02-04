# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="eastwood"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*) # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/home/rramirez/bin:$PATH"
export EDITOR=vim
export PAGER=less


# general purpose aliases
alias sl='ls'
alias tmuxa='tmux a'
alias celar='clear'
alias os='cat /etc/*release*'
alias xit='exit'
alias todo='vim ~/Code/todos/todos.md'
alias todos='todo'


# git related
alias gc='echo "git checkout" && git checkout'
alias gcom='echo "git commit" && git commit'
alias gcommit='echo "git commit" && git commit'
alias gbranch='echo "git branch" && git branch'
alias gbrancha='echo "git branch -a" && git branch -a'
alias gbra='echo "git branch -a" && git branch -a'
alias gr='echo "git remote -v" && git remote -v'
alias gremote='echo "git remote -v" && git remote -v'
alias ghist='echo "git log -p" && git log -p'
alias gpull='echo "git pull" && git pull'
alias gpush='echo "git push" && git push'
alias gs='echo "git status" && git status'
alias gstat='echo "git status" && git status'
alias gadd='echo "git add" && git add'
alias gdiff='echo "git diff" && git diff'
alias gdif='gdiff'
alias gd='gdiff'
alias gdc='echo "git diff --cached" && git diff --cached'
alias gpom='echo "git pull origin master" && git pull origin master'


# docker related
alias docker='sudo docker'
alias fig='sudo fig'
alias d='sudo docker'
alias dps='sudo docker ps -a'
alias di='sudo docker images' 
alias dat='sudo docker attach --sig-proxy=true'
alias dci="docker images | grep none | awk '{print \$3}' | xargs sudo docker rmi -f"
alias dc="docker rm -f \$(docker ps -q -a)"


# rackspace machine configs
alias rackvpn='sudo openconnect -b vpn1.dfw1.rackspace.com'
alias rackoff='sudo killall openconnect; sudo killall openconnect'
alias ts3='/opt/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh'


# laptop configs
alias touchpad-setup='sh ~/bin/logitech-t650-config.sh'
alias lower_res='xrandr --auto; xrandr --output eDP1 --mode 1920x1200'
alias work_primary_display='xrandr --output DP-0 --primary'
alias work_display_rearrange='xrandr --output HDMI2 --right-of eDP1; xrandr --output HDMI3 --above eDP1'
alias display_external_left='xrandr --output DP-0 --left-of LVDS-1; xrandr --output DP-1 --left-of LVDS-1; xrandr --output HDMI1 --left-of eDP1'
alias rescreen='xrandr --auto; display_external_left'
# TODO: configure 3/4 screens in square
# TODO: does the displaylink adapter play more nicely with my setup under DWM?
alias work_display_config='lower_res; work_primary_display; work_display_rearrange'

alias saweather='weather 78154'
alias saw='saweather'
alias hop='sh /home/rramirez/Code/sshuttle/sshuttle --dns -vvr rdev 0/0'
alias htop='sudo htop'
alias ports='sudo netstat -netpul'
alias rekey='killall xbindkeys; xbindkeys -f ~/.xbindkeysrc'
alias redwm='cd /usr/local/src/dwm-6.0; updpkgsums; makepkg -efi --noconfirm; killall dwm'


### Vim related
alias vimup="cd ~/.dotfiles; make vim"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# Ruby dev stuffs
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
