#!/bin/bash
abspath="$(readlink -f "$HOME/.config/niri/config.kdl")"
dotsroot="$(cd "$(dirname "$abspath")" && git rev-parse --show-toplevel)"
walldir="$dotsroot/wallpaper"
read -rp "Which wallpaper?(or ls to list already imported) (You can enter a full path(tildes allowed) to import a new one) " wall
wall="${wall/#\~/$HOME}"
if [ "$wall" = "ls" ]; then
  ls "$walldir" | sed 's/.png//g' | sed 's/bg//g'
  sleep 2
  read -rp "Which wallpaper, now that you have all the options? " wall
  wall="${wall/#\~/$HOME}"
fi
if [ -e "$wall" ]; then
  echo "New Wallpaper Detected! Previewing, press q to continue."
  pqiv "$wall"
  read -rp "What would you like the shorthand to be? Do not include file extensions. " shorthand
  if [ -f "$walldir/$shorthand.png" ]; then
    echo "Exiting, file already exists."
    sleep 2
    exit 1
  fi
  if [ "$shorthand" = "ls" ]; then
    echo "ls is a keyword. This file will be inaccesible and as such this program will be exiting."
    sleep 2
    exit 1
  fi
  magick "$wall" "$walldir/$shorthand.png"
  (cd "$dotsroot" && dotter deploy --force)
  sleep 1
  read -rp "Would you like to switch or not(y/n)" confirm
  if [ "$confirm" = "y" ]; then
    cp "$walldir/$shorthand.png" "$HOME/.config/niri/wallpaper/bg.png"
  else
    exit 0
  fi
elif [ -f "$walldir/$wall.png" ]; then
  cp "$walldir/$wall.png" "$HOME/.config/niri/wallpaper/bg.png"
else
  echo "Exiting, no file found. Did you use the shorthand you set when importing? "
  echo "Here are the current wallpapers."
  find "$walldir" | sed 's/.png//g' | sed 's/bg//g'
  sleep 3
  exit 1
fi
echo "Switching to the new wallpaper at dots/hypr/wallpaper/bg.png Note: Use magick to convert image formats!"
wallust run "$HOME/.config/niri/wallpaper/bg.png"
sleep 0.1
killall -SIGUSR2 waybar
swww img "$HOME/.config/niri/wallpaper/bg.png"
echo "Done! Automatically Closing in 3 seconds."
sleep 2
exit 0
