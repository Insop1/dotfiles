#!/bin/bash
mkdir -p ~/dotfiles/.config/ ~/dotfiles/scripts/

rsync -av --delete \
    ~/.config/{pipewire,hypr,fuzzel,mako,nvim,waybar,yazi,niri,foot} \
    ~/dotfiles/.config/

echo "synced"
