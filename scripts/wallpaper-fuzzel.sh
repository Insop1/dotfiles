#!/bin/bash

dir="$HOME/Wallpapers"

shopt -s nullglob
files=("${dir}"/*)
shopt -u nullglob

declare -A filtered

for file in "${files[@]}"; do
  no_ext="${file%.*}"

  if [[ -z "${filtered[$no_ext]}" || "$file" == *.sh ]]; then
        filtered["$no_ext"]="$file"
  fi
done

choice=$(printf '%s\n' "${filtered[@]##*/}" | sort | fuzzel --dmenu --only-match --prompt "Wallpaper: " --minimal-lines --width 51)
[[ -z "$choice" ]] && exit 0
path="$dir/$choice"

error=(notify-send "Wallpaper Error")
if [[ "$path" == *.sh ]]; then
  "$path" || "${error[@]}" "Script went wrong"
else
  err=$(awww img "$path" 2>&1) || "${error[@]}" "$err"
fi
