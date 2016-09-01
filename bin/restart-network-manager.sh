#!/bin/bash

sudo systemctl restart NetworkManager.service

sudo nmcli networking off
sudo nmcli networking on
