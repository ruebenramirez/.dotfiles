#!/usr/bin/env bash

echo "restarting redshift service"
systemctl --user stop redshift
sleep 5
systemctl --user start redshift
systemctl --user status redshift


