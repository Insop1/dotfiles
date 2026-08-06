#!/bin/bash

dir="$HOME/Wallpapers"

shopt -s nullglob
files=("${dir}"/*)
shopt -u nullglob

declare -A filtered

for file in "${files[@]}"; do
  no_ext="${file%.*}"

  if [[ ! -v "${filtered[$no_ext]}" || "$file" == *.sh ]]; then
        filtered["$no_ext"]="$file"
  fi
done

fuzzel=(fuzzel --dmenu --only-match --prompt "Wallpapers: " \
    --minimal-lines --lines 10 --width 50)

choice=$(printf '%s\n' "${filtered[@]##*/}" | sort | "${fuzzel[@]}" )
[[ -z "$choice" ]] && exit 0
path="$dir/$choice"

args=(-t grow --transition-fps 180 --transition-duration 2)
error=(notify-send "Wallpaper Error")
if [[ "$path" == *.sh ]]; then
  "$path" "${args[@]}" || "${error[@]}" "Script went wrong"
else
  err=$(awww img "$path" "${args[@]}" 2>&1) || "${error[@]}" "$err"
fi
