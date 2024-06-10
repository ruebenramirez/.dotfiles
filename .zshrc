# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.  # Look in ~/.oh-my-zsh/themes/
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
plugins=(git jsontools systemd docker)

source $ZSH/oh-my-zsh.sh

# z - jump around app
. ~/code/z/z.sh

# User configuration
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:/opt/android-studio/bin/:$PATH"
export EDITOR=vim
export PAGER=less

# helpful aliases
alias vi='vim'
alias k='kubectl'
alias eixt='exit'
alias hf='echo "hostname -f" && hostname -f'
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
alias ls='ls --color'
alias sl='ls'
alias lll='ls -lah'
alias ll='ls -lah'
alias lt='ls -lat'
alias lth='ls -lat | head'
alias celar='clear'
alias cleawr='clear'
alias os='cat /etc/*release*'
alias xit='exit'
alias htop='sudo htop'
alias ports='sudo netstat -netpul'
alias portsg='sudo netstat -netpul | grep $*'
alias curlperf='curl -w "\nperformance: %{time_connect} (conn) + %{time_starttransfer} (trans) = %{time_total} (total)\n"'
alias lowpower='sudo pm-powersave true'
alias highpower='sudo pm-powersave false'
alias tre='tree'
alias def='define'
alias psg='echo "ps auxf | grep -v grep | grep -i $* " && ps auxf | grep -v grep | grep -i $*'
alias gci='google-chrome --incognito'
alias t='tmux'
alias tls='tmux ls'
alias tmuxa='tmux a'
alias ta='tmux a'
alias tad='tmux a -d'
alias lynx='lynx -vikeys -accept_all_cookies'
alias update='pushd ~/.dotfiles/ && make update && popd && omz update'
alias powertop='sudo powertop'
alias nethogs='sudo nethogs'
alias ncdu='sudo ncdu'
alias writer='libreoffice --writer'
alias sheets='libreoffice --calc'
alias calc='sheets'
alias pbcopy='xclip -se c -i'
alias discord='Discord'
alias vido='cd ~/.dotfiles/ && vi Makefile'

### terraform aliases
alias tf='echo "terraform" && terraform'
alias tfp='echo "terraform plan -out tfplan" && terraform plan -out tfplan'
alias tfa='echo "terraform apply tfplan" && terraform apply tfplan'
alias tfd='echo "terraform destroy" && terraform destroy'


### git aliases
alias gg='echo "git grep" && git grep'
alias gco='echo "git checkout" && git checkout'
alias gcob='echo "git checkout -b" && git checkout -b'
alias gcom='echo "git commit" && git commit'
alias gcommit='echo "git commit" && git commit'
alias gb='echo "git branch" && git --no-pager branch'
alias gbr='echo "git branch --remote" && git branch --remote'
alias gbd='echo "git branch -D" && git branch -D'
alias gr='echo "git remote -v" && git remote -v'
alias ghist='echo "git log -p" && git log -p'
alias gpom='git branch | egrep "master|main" | xargs -I"{}" git pull -r origin {}'
alias gpush='echo "git push" && git push'
alias gps='echo "git push" && git push'
alias gfa='echo git fetch --all && git fetch --all'
alias gs='echo "git status" && git status'
alias gstat='echo "git status" && git status'
alias gadd='echo "git add" && git add'
alias gap='echo git add -p && git add -p'
alias gd='echo "git diff" && git diff'
alias gdc='echo "git diff --cached" && git diff --cached'
alias gri='echo "git rebase -i" && git rebase -i'
alias grim="git rebase -i $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"

### docker aliases
alias d='docker'
alias dps='docker ps -a'
alias di='echo "docker images" && docker images'
alias dat='echo "docker attach" && docker attach --sig-proxy=true'
alias dci="echo 'docker clean images' && docker images | grep none | awk '{print \$3}' | xargs sudo docker rmi -f"
alias dc='echo "docker clean zombie containers" && docker rm \$(docker ps -q -a)'
alias dcs='echo "docker-compose" && docker-compose'

### vpn stuffs
alias firevpn='/opt/firefox/firefox'
alias ntvpn='sudo vpnc nt.conf'
alias vpnoff='seq 2 | xargs -Iz sudo vpnc-disconnect;'
alias hop='sshuttle --dns -vvr home-prod 0/0'
alias hopvultr='sshuttle --dns -vvr vultr 0/0'
alias hoplinode='sshuttle --dns -vvr linode 0/0'
alias ntfort='sudo openfortivpn -c /etc/openfortivpn/newtek-config'


### Python dev
#export WORKON_HOME=~/Envs
#mkdir -p $WORKON_HOME
#source /usr/local/bin/virtualenvwrapper.sh
alias py='python3'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### Go dev
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/gocode
export PATH="$HOME/gocode/bin:$PATH"

### import project specific configs
. ~/.dotfiles/projects/.*rc
export PATH="/usr/local/opt/gettext/bin:$PATH"

# keychain used to store ssh session across local terminal shells
eval `keychain -q --eval ~/.ssh/id_ed25519`

# Rust dev
source $HOME/.cargo/env

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# new pyenv path
export PATH="/usr/local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval ""
fi

# python poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export PATH=$PATH:/usr/local/go/bin
