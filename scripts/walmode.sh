#!/usr/bin/env bash
# Usage: walmode.sh [get|toggle]
# Switches the wallust palette between dark16 and light16 and re-applies the current wallpaper.
cfg="$HOME/.config/wallust/wallust.toml"
bg="$HOME/.config/quickshell/bg"

current() {
  if grep -qE '^palette *= *"light16"' "$cfg"; then echo light; else echo dark; fi
}

case "${1:-get}" in
get)
  current
  ;;
toggle)
  if [ "$(current)" = light ]; then
    sed -i -E 's/^(palette *= *)"light16"/\1"dark16"/' "$cfg"
  else
    sed -i -E 's/^(palette *= *)"dark16"/\1"light16"/' "$cfg"
  fi
  [ -s "$bg" ] && wallust run "$bg"
  current
  ;;
*)
  echo "usage: $0 [get|toggle]" >&2
  exit 1
  ;;
esac
