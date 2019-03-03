#!/bin/bash

set +e -x

function installRedshift() {
	sudo apt-get install -y redshift
}

function setupLocalSystemdGeoclueService() {
	mkdir -p ~/.config/systemd/user/
	cat << EOF > ~/.config/systemd/user/geoclue-agent.service
[Unit]
Description=redshift needs to get a (geo)clue

[Service]
ExecStart=/usr/lib/geoclue-2.0/demos/agent

[Install]
WantedBy=default.target
EOF
	systemctl --user enable --now geoclue-agent.service
}


function unblockRedshiftInGeoClue() {
    GEOCLUE_CONFIG='/etc/geoclue/geoclue.conf'

    if [[ $(cat $GEOCLUE_CONFIG | grep -i redshift | wc -l) -lt 1 ]]; then
        sudo cp $GEOCLUE_CONFIG  "$GEOCLUE_CONFIG.BAK"
        sudo tee -a $GEOCLUE_CONFIG >> /dev/null <<'EOF'
[redshift]
allowed=true
system=false
users=
EOF
    else
        echo "already unblocked redshift in geoclue"
    fi
    cat $GEOCLUE_CONFIG
}

function runRedshift() {
    redshift
}

installRedshift
setupLocalSystemdGeoclueService
unblockRedshiftInGeoClue
# runRedshift
