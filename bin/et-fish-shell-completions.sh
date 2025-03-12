#!/usr/bin/env bash

# Create the completions directory if it doesn't exist
mkdir -p ~/.config/fish/completions

# Create the et completion file
cat << 'EOF' > ~/.config/fish/completions/et.fish
function __fish_et_hosts
    set -l config_hosts (sed -n 's/^Host //p' ~/.ssh/config 2>/dev/null | grep -v '\*')
    set -l known_hosts (sed -n 's/^[^ ]*[ ,]//p' ~/.ssh/known_hosts 2>/dev/null | cut -d ' ' -f 1 | tr ',' '\n')
    echo $config_hosts $known_hosts | sort -u
end

complete -c et -f -a '(__fish_et_hosts)'
EOF

# Set correct permissions
chmod 644 ~/.config/fish/completions/et.fish

echo "Eternal Terminal (et) completion for Fish has been set up."
echo "Please restart your Fish shell or run 'source ~/.config/fish/config.fish' to apply changes."

