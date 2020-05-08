#!/usr/bin/python3

import os
import subprocess

DEBUG = False


def setup_keyboard():
    if is_apple_device() or has_apple_keyboard_attached():
        configure_apple_keyboard()


def configure_apple_keyboard():
    os.system("""
              echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
            """)
    os.system("""
              echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout
              """)
    os.system("""
              echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_opt_cmd
              """)


def is_apple_device():
    file = '/sys/devices/virtual/dmi/id/chassis_vendor'
    search = 'apple'
    return find_in_file(file, search)


def has_apple_keyboard_attached():
    usb_devices = subprocess.check_output("lsusb", text=True)
    if DEBUG:
        print("printing usb devices")
        print(usb_devices)
    if 'Apple' not in usb_devices:
        return False
    return True


def find_in_file(file, search_term, case_insensitive=True):
    line = read_line_from_file(file)
    if case_insensitive:
        line = line.lower()
    if search_term not in line:
        return False
    return True


def read_line_from_file(file):
    f = open(file)
    line = f.readline()
    f.close()
    return line


def main():
    if DEBUG:
        print("is this an apple device?")
        print(is_apple_device())

        print("is an apple keyboard plugged in?")
        print(has_apple_keyboard_attached())

    setup_keyboard()


if __name__ == "__main__":
    main()
