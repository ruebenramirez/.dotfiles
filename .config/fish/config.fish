if status --is-interactive
    set -lx SHELL fish
    keychain -q --eval ~/.ssh/id_ed25519 | source
end


# Nix on Debian
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
end
# End Nix on Debian

# Nix on NixOS
if test -e /home/$USER/.nix-profile/bin
    fish_add_path /home/$USER/.nix-profile/bin
end
# End Nix on NixOS

if status --is-interactive
  eval (direnv hook fish)
end

if test -d $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin
end


set -gx EDITOR vim
set -x TMUX_TMPDIR /tmp

fish_add_path ~/bin

# helpful aliases

# nav up directories
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

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
alias n="tmux new-session -c ~/notes"
alias mn="mosh xps-nixos-ipv4 -- tmux new-session -c ~/notes"
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
alias gws="watch -n 2 'git log --pretty=format:\"%h - %s%d\" --decorate'"

function git-push-tags-force
    if test (count $argv) -eq 0
        set remote_name "origin"
    else
        set remote_name $argv[1]
    end

    set -l tags (git tag -l)

    if test -z "$tags"
        echo "No local tags found."
        return 1
    end

    echo "Force pushing all tags to remote: $remote_name"

    for tag in $tags
        echo "Force pushing tag: $tag"
        git push $remote_name refs/tags/$tag:refs/tags/$tag --force
    end

    echo "All tags have been force pushed to $remote_name."
end


#jj aliases
alias jjwl='watch --color -c "jj log -r \"all()\" --color always"'
alias jjs="jj status"
alias jjl="jj log -r \"all()\" --patch"
alias jjd="jj diff"
alias jjdr="jj diff -r"
alias jjf="jj git fetch --all-remotes"
alias jjnm="jj git fetch --all-remotes && jj new master@origin"
alias jjgp="jj git push --ignore-immutable"
alias jju="jj config set --user user.name \"Rueben Ramirez\" && jj config set --user user.email \"ruebenramirez@gmail.com\""
alias jjds="jj describe --ignore-immutable"
alias jja="jj abandon --ignore-immutable"
alias jjr="jj rebase --ignore-immutable"

function jj-git-tag
    if test (count $argv) -ne 2
        echo "Usage: jj-git-tag <tag-name> <jj-revision>"
        return 1
    end

    set tag_name $argv[1]
    set jj_rev $argv[2]

    # Export JJ revisions to Git
    jj git export

    # Get the Git commit hash for the JJ revision
    set git_hash (jj show --no-pager -r $jj_rev --git | grep "Commit ID:" | cut -d " " -f 3)

    if test -z "$git_hash"
        echo "Error: Could not find Git hash for JJ revision $jj_rev"
        return 1
    end

    # Create the Git tag
    git tag $tag_name $git_hash

    if test $status -eq 0
        echo "Successfully created Git tag $tag_name for JJ revision $jj_rev (Git hash: $git_hash)"
    else
        echo "Error: Failed to create Git tag"
        return 1
    end
end


# docker aliases
if command -v docker &>/dev/null
    alias d="docker"
    alias dps="docker ps -a"
    alias di="docker images"
    alias dat="docker attach --sig-proxy=true"
    alias dci="docker images | grep none | awk '{print $3}' | xargs -I'{}' sudo docker rmi -f {}"
    alias dc="docker rm $(docker ps -q -a)"
    alias dcs="docker-compose"
end

# terraform aliases
alias tf="terraform"
alias tfp="terraform plan -out tfplan"
alias tfa="terraform apply tfplan"
alias tfd="terraform destroy"

alias pbedit="sudo /nix/store/*-samba-*/bin/pdbedit"

# alias for timer and sounding alarm when finished
function tmr
    set -l duration $argv[1]

    if test (count $argv) -lt 2
        timer $duration; date; sound-alarm;
    else
        # Get all arguments after the first one (argv[2:])
        set -l name_parts $argv[2..-1]
        set -l name (string join " " $name_parts)

        timer $duration --name "$name"; date; sound-alarm
    end
end

# random alphanumeric output
#   e.g. rndm 5: Gu4br
function rndm
    cat /dev/random | tr -dc 'a-zA-Z0-9' | head -c $argv
end

# random output with symbols
#   e.g. rndms 5: x1^3T
function rndms
    cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-=[]{}|;:,.<>?/`~' | head -c $argv
end
