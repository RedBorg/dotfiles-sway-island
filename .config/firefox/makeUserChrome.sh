#!/usr/bin/env bash

chromePath="$HOME/.mozilla/firefox/tnvezmh3.default/chrome"

sassc ~/.config/firefox/firefoxTheme.scss "$chromePath/userChrome-noDef.css"
sassc ~/.config/firefox/firefoxContent.scss "$chromePath/userContent-noDef.css"
sassc ~/.config/firefox/scrollbarTheme.scss "$chromePath/scrollbar.as.css"

cp ~/.config/firefox/userChrome.js ~/.mozilla/firefox/tnvezmh3.default/chrome/

#cat ~/.cache/wal/colors.css ~/.config/firefox/firefoxTheme.css > ~/.mozilla/firefox/tnvezmh3.default/chrome/userChrome.css
