#!/bin/env bash
swayidle timeout 300 "~/.config/swaylock/lock.sh 50" \
  timeout 600 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "~/.config/swaylock/lock.sh 50" &
