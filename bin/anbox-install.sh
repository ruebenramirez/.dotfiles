#!/usr/bin/env bash


# main installation instructions: https://docs.anbox.io/userguide/install.html


# install kernel modules: https://docs.anbox.io/userguide/install_kernel_modules.html
sudo add-apt-repository ppa:morphis/anbox-support
sudo apt update
sudo apt install linux-headers-generic anbox-modules-dkms

sudo apt install software-properties-common

sudo modprobe ashmem_linux
sudo modprobe binder_linux

ls -1 /dev/{ashmem,binder}

if [[ $(ls -1 /dev/{ashmem,binder} | wc -l) -lt 2]]; then
    echo "didn't load the kernel modules properly"
    exit 1
fi



