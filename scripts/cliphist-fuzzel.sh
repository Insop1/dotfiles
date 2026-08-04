#!/bin/bash

options="wipe\t󰩹 Clear history\n"
choice=$({ cliphist list; printf "$options"; } | fuzzel --dmenu --with-nth 2 --prompt "Clipboard: " --minimal-lines --lines 10 --width 50)

id=${choice%%$'\t'*}

case "$id" in
  "") exit 0 ;;
  wipe) cliphist wipe ;;
  *) printf '%s' "$choice" | cliphist decode | wl-copy ;;
esac

