#!/usr/bin/env bash

patch_zshrc() {
    echo "patching up /etc/zshrc"
    sudo cat << EOF >> /etc/zshrc
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
EOF
}


check_if_nix_broken() {
    COUNT=$(grep -c -i nix /etc/zshrc)
    if [[ $COUNT -lt 4 ]]; then
        patch_zshrc
    else
        echo "Nix should be working";
    fi
}

check_if_nix_broken
