#!/usr/bin/env bash

killall waybar

cd "$(dirname "$0")" || exit
sh ./makeStyle.sh``

waybar &
