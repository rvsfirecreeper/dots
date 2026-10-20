#!/usr/bin/env bash
# Usage: walmode.sh [get|toggle|dark|light|apply]
# Switches between the dark and light Catppuccin flavors (see dots.nix) without a rebuild.
# Both flavors are rendered at build time into ~/.local/share/dots/colors/{dark,light};
# this links the chosen one into place and reloads what supports it.
src="$HOME/.local/share/dots/colors"
state="$HOME/.local/state/dots/mode"

current() { cat "$state" 2>/dev/null || echo dark; }

apply() {
  local mode="$1" dir="$src/$1" f rel
  [ -d "$dir" ] || { echo "missing $dir" >&2; exit 1; }
  while IFS= read -r -d '' f; do
    rel="${f#"$dir"/}"
    mkdir -p "$HOME/$(dirname "$rel")"
    ln -sfn "$f" "$HOME/$rel"
  done < <(find "$dir" \( -type f -o -type l \) -print0)
  mkdir -p "$(dirname "$state")"
  echo "$mode" >"$state"
  if [ -z "${NORELOAD:-}" ]; then
    pkill -USR1 -x kitty 2>/dev/null
    hyprctl reload >/dev/null 2>&1
  fi
  return 0
}

case "${1:-get}" in
get) current ;;
apply) apply "$(current)" ;;
dark | light) apply "$1"; current ;;
toggle)
  if [ "$(current)" = light ]; then apply dark; else apply light; fi
  current
  ;;
*)
  echo "usage: $0 [get|toggle|dark|light|apply]" >&2
  exit 1
  ;;
esac
