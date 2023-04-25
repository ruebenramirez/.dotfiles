if status --is-interactive
    keychain -q --eval ~/.ssh/id_ed25519 | source
    keychain -q --eval ~/.ssh/exelixis_github_ed25519 | source
end

# helpful aliases

# typos
alias k="kubectl"
alias eixt="exit"
alias xit="exit"
alias lll="ls -lah"
alias sl="ls"
alias tmuxa="tmux a"
alias celar="clear"
alias cleawr="clear"
alias cleargs="clear && gs"
alias tre="tree"

# shortcuts
alias hf="hostname -f"
alias vi="vim"
alias setclip="xclip -selection c"
alias getclip="xclip -selection clipboard -o"
alias ll="ls -lah"
alias lt="ls -lat"
alias lth="ls -lat | head"
alias os="cat /etc/*release*"
alias visio="pencil"
alias cb="xsel --clipboard"
#alias curlperf="curl -w "\nperformance: %{time_connect} (conn) + %{time_starttransfer} (trans) = %{time_total} (total)\n""
alias rc="rails console"
alias rs="rails server"
alias def="define"
#alias psg="ps auxf | grep -v grep | grep -i $*"
alias psg="ps auxf | grep -v grep | grep -i $argv"
alias t="tmux"
alias tls="tmux ls"
alias ta="tmux a"
alias tad="tmux a -d"
alias lynx="lynx -vikeys -accept_all_cookies"
alias writer="libreoffice --writer"
alias sheets="libreoffice --calc"
alias calc="sheets"
alias pbcopy="xclip -se c -i"
alias discord="Discord"
alias vido="cd ~/.dotfiles/ && vi Makefile"

# make me a sandwhich
alias wifi="sudo sh ~/bin/wifi $argv"
alias htop="sudo htop"
alias light="sudo light"
alias ports="sudo netstat -netpul"
#alias portsg="sudo netstat -netpul | grep $*"
alias portsg="sudo netstat -netpul | grep $argv"
alias sdig="sudo csysdig"
alias powertop="sudo powertop"
alias nethogs="sudo nethogs"
alias lowpower="sudo pm-powersave true"
alias highpower="sudo pm-powersave false"
alias wifi="sudo systemctl restart networking NetworkManager && nm-applet &"


# git aliases
alias gg="git grep"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git commit"
alias gb="git --no-pager branch"
alias gbr="git branch --remote"
alias gba="git branch -a"
alias gbd="git branch -D"
alias grv="git remote -v"
alias gfa="git fetch --all"
alias gs="git status"
alias gadd="git add"
alias gd="git diff"
alias gdc="git diff --cached"
alias gri="git rebase -i"

# docker aliases
alias d="docker"
alias dps="docker ps -a"
alias di="docker images"
alias dat="docker attach --sig-proxy=true"
alias dci="docker images | grep none | awk '{print \$3}' | xargs sudo docker rmi -f"
alias dc="docker rm \$(docker ps -q -a)"
alias dcs="docker-compose"

# terraform aliases
alias tf="terraform"
alias tfp="terraform plan -out tfplan"
alias tfa="terraform apply tfplan"
alias tfd="terraform destroy"


