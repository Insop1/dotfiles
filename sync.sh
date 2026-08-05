#!/bin/bash
mkdir -p ~/dotfiles/.config/ ~/dotfiles/scripts/

rsync -av --delete \
    ~/.config/{pipewire,easyeffects,fuzzel,hypr,kitty,mako,nvim,waybar,yazi,uwsm,niri,foot} \
    ~/dotfiles/.config/

echo "synced"
