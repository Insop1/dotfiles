#!/bin/bash
mkdir -p ~/dotfiles/.config/ ~/dotfiles/scripts/ ~/dotfiles/.local/share/color-schemes/

rsync -av --delete \
    ~/.config/{pipewire,easyeffects,fuzzel,hypr,kitty,mako,nvim,waybar,yazi,uwsm,niri,foot} \
    ~/dotfiles/.config/

rsync -av --delete ~/.local/share/color-schemes/ ~/dotfiles/.local/share/color-schemes/

echo "synced"
