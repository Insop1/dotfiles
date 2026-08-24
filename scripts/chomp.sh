#!/usr/bin/env bash
set -euo pipefail

crf=40
crf_set=0
preset=4
scale=""
suffix="_c"

usage() {
    cat >&2 <<'EOF'
usage: chomp [-c CRF] [-p PRESET] [-1080] FILE...

  -c CRF     quality, 0-63, lower is better (default 40, or 36 with -1080)
  -p PRESET  0-13, lower is slower and smaller (default 4)
  -1080      downscale to 1080p
EOF
    exit 1
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c) crf="$2"; crf_set=1; shift 2 ;;
        -p) preset="$2"; shift 2 ;;
        -1080) scale="scale=1920:-2"; shift ;;
        -h|--help) usage ;;
        --) shift; break ;;
        -*) echo "chomp: unknown flag $1" >&2; usage ;;
        *) break ;;
    esac
done

[[ -n $scale && $crf_set -eq 0 ]] && crf=36

(( $# )) || usage
for cmd in ffmpeg ffprobe; do
    command -v "$cmd" >/dev/null || { echo "chomp: $cmd not found" >&2; exit 1; }
done

for f in "$@"; do
    [[ -f $f ]] || { echo "chomp: skipping $f" >&2; continue; }

    out="${f%.*}${scale:+_1080p}${suffix}.mp4"
    [[ -e $out ]] && { echo "chomp: $out exists, skipping" >&2; continue; }

    res=$(ffprobe -v error -select_streams v:0 \
          -show_entries stream=width,height -of csv=p=0:s=x "$f" 2>/dev/null) || res="?"

    printf ':: %s\n   %s%s, crf %s, preset %s\n' \
        "$f" "$res" "${scale:+ -> 1080p}" "$crf" "$preset"

    args=(-i "$f" -c:v libsvtav1 -crf "$crf" -preset "$preset"
          -svtav1-params tune=0:film-grain=8 -c:a copy)
    [[ -n $scale ]] && args+=(-vf "$scale")

    ffmpeg -hide_banner -loglevel warning -stats "${args[@]}" "$out"

    before=$(stat -c %s "$f")
    after=$(stat -c %s "$out")
    printf '   %s -> %s  (%d%%)\n\n' \
        "$(numfmt --to=iec "$before")" \
        "$(numfmt --to=iec "$after")" \
        $(( after * 100 / before ))
done
