# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="eastwood"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*) # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git encode64 jsontools redis-cli systemd vagrant rails ruby debian docker)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$HOME/bin:/usr/local/packer:/opt/jdk1.8.0_112/bin:$HOME/.rbenv/bin:/opt/franz:$HOME/.local/bin:$PATH"
export EDITOR=vim
export PAGER=less

# helpful aliases
alias eixt='exit'
alias hf='echo "hostname -f" && hostname -f'
alias vi='vim'
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
alias sl='ls'
alias lll='ls -lah'
alias ll='ls -lah'
alias lt='ls -lat'
alias lth='ls -lat | head'
alias tmuxa='tmux a'
alias celar='clear'
alias os='cat /etc/*release*'
alias xit='exit'
alias htop='sudo htop'
alias ports='sudo netstat -netpul'
alias portsg='sudo netstat -netpul | grep $*'
alias macports='sudo lsof -n -i4TCP | grep LISTEN'
alias rekey='killall xbindkeys; xbindkeys -f ~/.xbindkeysrc'
alias redwm='cd /usr/local/src/dwm-6.0; make clean && sudo make install'
alias visio='pencil'
alias cb='xsel --clipboard'
alias gn='geeknote'
alias curlperf='curl -w "\nperformance: %{time_connect} (conn) + %{time_starttransfer} (trans) = %{time_total} (total)\n"'
alias timestamp='date +%Y-%m-%d:%H:%M:%S'
alias timestamp-hyphenated='date +%Y-%m-%d-%H-%M-%S'
alias datestamp='date +%Y-%m-%d'
alias rescreen='sh ~/bin/init-display.sh'
alias t='todo'
alias tl='todolist'
alias lowpower='sudo pm-powersave true'
alias highpower='sudo pm-powersave false'
alias wifi='sudo systemctl restart networking NetworkManager && nm-applet &'
alias tree='tree | less'
alias tre='tree'
alias rc='rails console'
alias rs='rails server'
alias sdig='sudo csysdig'
alias pidgin='pidgin & pidgin &' # pidgin doesn't always reload the UI in i3
alias def='define'
alias psg='echo "ps auxf | grep -v grep | grep -i $* " && ps auxf | grep -v grep | grep -i $*'
alias gci='google-chrome --incognito'
alias sound-config='pavucontrol &'
alias t='tmux'
alias tls='tmux ls'
alias ta='tmux a'
alias tad='tmux a -d'

### git aliases
alias gco='echo "git checkout" && git checkout'
alias gcob='echo "git checkout -b" && git checkout -b'
alias gcom='echo "git commit" && git commit'
alias gcommit='echo "git commit" && git commit'
alias gb='echo "git branch" && git branch'
alias gbranch='echo "git branch" && git branch'
alias gbrancha='echo "git branch -a" && git branch -a'
alias gbra='echo "git branch -a" && git branch -a'
alias gbd='echo "git branch -D" && git branch -D'
alias gbrd='echo "git branch -D" && git branch -D'
alias gr='echo "git remote -v" && git remote -v'
alias gremote='echo "git remote -v" && git remote -v'
alias ghist='echo "git log -p" && git log -p'
alias gpull='echo "git pull" && git pull'
alias gpl='echo "git pull" && git pull'
alias gpom='echo "git pull origin master" && git pull origin master'
alias gpush='echo "git push" && git push'
alias gps='echo "git push" && git push'
alias gfa='echo git fetch --all && git fetch --all'
alias gs='echo "git status" && git status'
alias gstat='echo "git status" && git status'
alias gadd='echo "git add" && git add'
alias gap='echo git add -p && git add -p'
alias gdiff='echo "git diff" && git diff'
alias gdif='gdiff'
alias gd='gdiff'
alias gdc='echo "git diff --cached" && git diff --cached'
alias grim='echo "git rebase -i master" && git rebase -i master'



### docker aliases
alias d='docker'
alias dps='docker ps -a'
alias di='echo "docker images" && docker images'
alias dat='echo "docker attach" && docker attach --sig-proxy=true'
alias dci="echo 'docker clean images' docker images | grep none | awk '{print \$3}' | xargs sudo docker rmi -f"
alias dc='echo "docker clean zombie containers" docker rm \$(docker ps -q -a)'

### vpn stuffs
alias firevpn='/opt/firefox/firefox'
alias ntvpn='sudo vpnc nt.conf'
alias vpnoff='seq 2 | xargs -Iz sudo vpnc-disconnect;'
alias hop='sshuttle --dns -vvr home-prod 0/0'
alias hopvultr='sshuttle --dns -vvr vultr 0/0'
alias hoplinode='sshuttle --dns -vvr linode 0/0'
alias ntfort='sudo openfortivpn -c /etc/openfortivpn/newtek-config'

### Python dev
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

### Node version manager (NVM)
export NVM_DIR="/home/rramirez/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

### Ruby dev
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

### Go dev
export GOPATH=$HOME/gocode
export PATH="$HOME/gocode/bin:$PATH"

### import project specific configs
. ~/.dotfiles/projects/.*rc
export PATH="/usr/local/opt/gettext/bin:$PATH"
eval `keychain --eval ~/.ssh/id_rsa`
