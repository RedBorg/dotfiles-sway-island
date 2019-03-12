#!/bin/env bash

cd "$(dirname "$0")" || exit

# the .txt files are simple text files that have a list of all
# the filenames (no paths) of the images that should make the
# bar have a different background alpha
dark_list="$(cat dark_list.txt)"

midDark_list="$(cat midDark_list.txt)"

source "$HOME/.cache/wal/colors.sh"

cp unvariabled_style.css style.css

filename=$(basename -- "$wallpaper")

if [[ $dark_list == *"$filename"* ]]; then
  sed -i "s/\$alpha/0.5/" style.css
elif [[ $midDark_list == *"$filename"* ]]; then
  sed -i "s/\$alpha/0.25/" style.css
else
  sed -i "s/\$alpha/0.1/" style.css
fi
