#!/usr/bin/env bash

nix-store --query --requisites /run/current-system \
  | cut -d- -f2- \
  | sort \
  | uniq
