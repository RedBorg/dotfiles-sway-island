# Red's Doots

Those are my dotfiles for my pywal-based.

## Main software
- [sway](https://github.com/swaywm/sway)
  - *note: A 1.0+ version would work better*
- [termite](https://github.com/thestinger/termite)
- [pywal](https://github.com/dylanaraps/pywal)
  - **optional:**
    - [wpgtk](https://github.com/deviantfero/wpgtk), for gtk theming
    - [haishoku](https://github.com/LanceGin/haishoku), an alternate palette 
      generator
    - [colorz](https://github.com/metakirby5/colorz), color scheme generator
- [rofi](https://github.com/DaveDavenport/rofi)
  - *note: you can also use another dmenu-like menu, it should be possible to 
    change that easily*
- [zsh](https://www.zsh.org/)
  - [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [firefox](https://www.mozilla.org/en-US/firefox/new/)
  - the automatic theme reloading is done using [firefox-quantum-userchromejs
    ](https://github.com/nuchi/firefox-quantum-userchromejs)
  - [SassC](https://github.com/sass/sassc)
- [nnn](https://github.com/jarun/nnn)
- [neovim](https://github.com/neovim/neovim)
  - [vim-plug](https://github.com/junegunn/vim-plug)
- [waybar](https://github.com/Alexays/Waybar)
- [swaylock](https://github.com/swaywm/swaylock)
  - [ffmpeg](https://ffmpeg.org/)
  - [grim](https://github.com/emersion/grim)

## Cool things
### On-the-fly theme reloading for Firefox

If you install [firefox-quantum-userchromejs
](https://github.com/nuchi/firefox-quantum-userchromejs), you can benefit from 
the on-the-fly reloading when you run `./makeUserChrome.sh` in 
`~/.config/firefox/`. The script at `.config/firefox/userChrome.js` will by 
default check each 500ms, but you can change that by setting the 2nd argument 
of `window.setInterval` situated at the end of the file.

This reloading not only allows for easier developing, but also allows pywal to 
change the colours automatically.

### Cool island-ish style for firefox
By using custom css, we're able to change firefox quite a bit, and it evens 
pickups pywal's colours.

##### [little very blurry video](https://i.imgur.com/0DNBqlO.mp4)

##### Image:
![image](https://i.imgur.com/FtlKtDA.png)

### Transparent waybar that adapts to wallpapers

![three images from three different bars](https://i.imgur.com/0kAjrzd.png)

Because not all wallpapers are the same, by adding the filename (the filename 
(`example.png`), not the path (`~/.wall/example.png`)) of a wallpaper to either 
`~/.config/waybar/dark_list.txt` or `~/.config/waybar/midDark_list.txt`, the 
alpha of the bar will adapt when you run `~/.config/waybar/makeStyle.sh` (run 
automatically on configuration reload)

### Simple swaylock
![locked screen](https://i.imgur.com/HDgGwve.png)

`~/.config/swaylock/lock.sh [sigma]` locks your screen by blurring it and 
compositing a random logo on top. It uses pywal's colours and is super fast 
thanks to ffmpeg which is way faster than ImageMagick.

## Notes

Even though I tried my best to make this as portable as possible, I was 
sometime obligated to hardcode some values.

For these dotfiles, the user is named `master`, so search for that term in all 
files and change it to yours.

For firefox the profile name changes, so go in 
`~/.config/firefox/makeUserChrome.sh` and change the directory to your own.

Also, sometimes, changing the pywal theme will crash firefox, so be careful.

## Licensing
Except if stated otherwise, this work is licensed under WTFPLv2:

```plaintext
        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                    Version 2, December 2004 

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
