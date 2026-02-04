#!/bin/bash
wallust run "$1" 
killall -SIGUSR2 waybar
cd $(dirname $(realpath "$HOME/.config/niri/config.kdl"))
cd $(git rev-parse --show-toplevel)
base=$(basename "$1")
rm ./utils/swaylock
sed "s/bg\.png/$base/g" ./utils/swaylock.temp > ./utils/swaylock
for i in $(sed -n 's/^Path=//p' "$HOME/.mozilla/firefox/profiles.ini"); do
  cp "$1" "$HOME/.mozilla/firefox/$i/chrome/wallpaper.png" 
done
