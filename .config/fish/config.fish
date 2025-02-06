if status --is-interactive
    set -lx SHELL fish
    keychain -q --eval ~/.ssh/id_ed25519 | source
end

set -gx EDITOR vim
set -x TMUX_TMPDIR /tmp

fish_add_path ~/bin

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
alias nup="nix-update"
alias hf="hostname -f"
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
alias tmls="tmux ls"
alias tmks="tmux kill-session -a"
alias tma="tmux a"
alias tmad="tmux a -d"
alias lynx="lynx -vikeys -accept_all_cookies"
alias writer="libreoffice --writer"
alias sheets="libreoffice --calc"
alias calc="sheets"
alias pbcopy="xclip -se c -i"
alias discord="Discord"
alias vido="cd ~/.dotfiles/ && vi Makefile"
alias girn="grep -irn"
alias vin="cd ~/Sync/notes && /nix/store/sd4l8b6kjwxghizc0cqsgxl4f14cmx0z-neovim-0.10.2/bin/vi"


# make me a sandwhich
alias wifi="sudo sh ~/bin/wifi $argv"
alias htop="sudo htop"
alias light="sudo light"
alias ports="sudo netstat -netpul"
#alias portsg="sudo netstat -netpul | grep $*"
alias portsg="sudo netstat -netpul | grep $argv"
alias sdig="sudo csysdig"
alias powertop="sudo powertop"
alias nethogs="sudo nethogs -b"
alias lowpower="sudo pm-powersave true"
alias highpower="sudo pm-powersave false"
alias wifi="sudo systemctl restart networking NetworkManager && nm-applet &"

# tmux aliases
alias tls="tmux ls"
alias tmls="tmux ls"
alias tad="tmux a -d"
alias tmad="tmux a -d"


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

#jj aliases
alias jjwl='watch --color -c "jj log -r \"all()\" --color always"'
alias jjs="jj status"
alias jjl="jj log -r \"all()\" --patch"
alias jjd="jj diff"
alias jjdr="jj diff -r"
alias jjf="jj git fetch --all-remotes"
alias jjnm="jj git fetch --all-remotes && jj new master@origin"
alias jjgp="jj git push"
alias jju="jj config set --user user.name \"Rueben Ramirez\" && jj config set --user user.email \"ruebenramirez@gmail.com\""
alias jjds="jj describe"
alias jja="jj abandon"

# docker aliases
alias d="docker"
alias dps="docker ps -a"
alias di="docker images"
alias dat="docker attach --sig-proxy=true"
alias dci="docker images | grep none | awk '{print $3}' | xargs -I'{}' sudo docker rmi -f {}"
alias dc="docker rm $(docker ps -q -a)"
alias dcs="docker-compose"

# terraform aliases
alias tf="terraform"
alias tfp="terraform plan -out tfplan"
alias tfa="terraform apply tfplan"
alias tfd="terraform destroy"


