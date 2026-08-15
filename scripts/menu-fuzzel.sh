#!/bin/bash

# 󰐥 󰜉 󰤄 󰍃 󰌾 󰍁

options=("󰍁 Lock" "󰍃 Logout" "󰜉 Reboot" "󰐥 Power Off" "󰅖 Cancel")
fuzzel=(fuzzel --dmenu --prompt "Power Menu:" \
    --minimal-lines --width 12 --nth-delimiter " " --accept-nth 2)

choice=$(printf "%b\n" "${options[@]}" | "${fuzzel[@]}" )
[[ -z "$choice" ]] && exit 0

desktop="$XDG_CURRENT_DESKTOP"
reboot=(systemctl reboot)
poweroff=(systemctl poweroff)

case "$desktop" in
    Hyprland) 
        logout=(hyprshutdown --post-cmd "uwsm stop") 
        reboot=(hyprshutdown --post-cmd "systemctl reboot")
        poweroff=(hyprshutdown --post-cmd "systemctl poweroff")
        ;;
    niri) logout=(niri msg action quit --skip-confirmation) ;;
    *) logout=(notify-send "Logout error" "No logout specified for this desktop")
esac

case "$choice" in
    Lock) hyprlock ;;
    Logout) "${logout[@]}" ;;
    Reboot) "${reboot[@]}" ;;
    Power) "${poweroff[@]}" ;;
    Cancel|"") exit 0 ;;
esac
