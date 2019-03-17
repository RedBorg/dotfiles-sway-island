#!/usr/bin/env bash

sassc ~/.config/firefox/firefoxTheme.scss ~/.mozilla/firefox/tnvezmh3.default/chrome/userChrome-noDef.css
sassc ~/.config/firefox/firefoxContent.scss ~/.mozilla/firefox/tnvezmh3.default/chrome/userContent-noDef.css
sassc ~/.config/firefox/scrollbarTheme.scss ~/.mozilla/firefox/tnvezmh3.default/chrome/scrollbar.as.css

cp ~/.config/firefox/userChrome.js ~/.mozilla/firefox/tnvezmh3.default/chrome/

#cat ~/.cache/wal/colors.css ~/.config/firefox/firefoxTheme.css > ~/.mozilla/firefox/tnvezmh3.default/chrome/userChrome.css
