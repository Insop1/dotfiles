#!/bin/bash

mkdir -p ~/dotfiles/.config/
cp -rf ~/.config/{pipewire,easyeffects,fuzzel,hypr,kitty,mako,nvim,waybar,yazi,uwsm,niri,foot} ~/dotfiles/.config/

mkdir -p ~/dotfiles/scripts/
cp -rf ~/.local/bin/*.sh ~/dotfiles/scripts/
echo "copied"
