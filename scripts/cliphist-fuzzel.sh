#!/bin/bash

options="wipe\t󰩹 Clear history\n"
fuzzel=(fuzzel --dmenu --counter --with-nth 2 --prompt "Clipboard: " \
    --minimal-lines --lines 10 --width 50)

choice=$({ cliphist list; printf "$options"; } | "${fuzzel[@]}")

id=${choice%%$'\t'*}

case "$id" in
  "") exit 0 ;;
  wipe) cliphist wipe ;;
  *) printf '%s' "$choice" | cliphist decode | wl-copy ;;
esac

