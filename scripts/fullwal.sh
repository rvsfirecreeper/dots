#!/bin/bash
wallust run "$1" 
killall -SIGUSR2 waybar
cd $(dirname $(realpath "$HOME/.config/niri/config.kdl"))
cd $(git rev-parse --show-toplevel)
cp "$1" "/usr/share/backgrounds/bg"
base=$(basename "$1")
rm ./utils/swaylock
sed "s/bg\.png/$base/g" ./utils/swaylock.temp > ./utils/swaylock
prefix="$HOME/.mozilla/firefox"
for i in $(sed -n 's/^Path=//p' "$HOME/.mozilla/firefox/profiles.ini"); do
  cp "$1" "$prefix/$i/chrome/wallpaper.png"
  rm "$prefix/$i/chrome/ShyFox/shy-variables.css" || echo ""
  ln -s "$HOME/.shyfox.css" "$prefix/$i/chrome/ShyFox/shy-variables.css" || echo "" 
done
