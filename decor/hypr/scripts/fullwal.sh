#!/bin/bash
abspath="$(readlink -f "$HOME/.config/hypr/hyprland.conf")"
dotsroot="$(cd "$(dirname "$abspath")" && git rev-parse --show-toplevel)"
walldir="$dotsroot/wallpaper"
read -rp "Which wallpaper?(or ls to list already imported) (You can enter a full path(tildes allowed) to import a new one) " wall
wall="${wall/#\~/$HOME}"
if [ "$wall" = "ls" ]; then
  ls "$walldir" | sed 's/.jpg//g' | sed 's/bg//g'
  sleep 2
  read -rp "Which wallpaper, now that you have all the options? " wall
  wall="${wall/#\~/$HOME}"
fi
if [ -e "$wall" ]; then
  echo "New Wallpaper Detected! Previewing, press q to continue."
  pqiv "$wall"
  read -rp "What would you like the shorthand to be? Do not include file extensions. " shorthand
  if [ -f "$walldir/$shorthand.jpg" ]; then
    echo "Exiting, file already exists."
    sleep 2
    exit 1
  fi
  if [ "$shorthand" = "ls" ]; then
    echo "ls is a keyword. This file will be inaccesible and as such this program will be exiting."
    sleep 2
    exit 1
  fi
  magick "$wall" "$walldir/$shorthand.jpg"
  (cd "$dotsroot" && dotter deploy --force)
  echo "New Wallpaper Detected! Previewing, press q to continue."
  sleep 1
  read -rp "Would you like to switch or not(y/n)" confirm
  if [ "$confirm" = "y" ]; then
    cp "$walldir/$shorthand.jpg" "$walldir/bg.jpg"
  else
    exit 0
  fi
elif [ -f "$walldir/$wall.jpg" ]; then
  cp "$walldir/$wall.jpg" "$walldir/bg.jpg"
else
  echo "Exiting, no file found. Did you use the shorthand you set when importing? "
  echo "Here are the current wallpapers."
  find "$walldir" | sed 's/.jpg//g' | sed 's/bg//g'
  sleep 3
  exit 1
fi
echo "Switching to the new wallpaper at dots/hypr/wallpaper/bg.jpg Note: Use magick to convert image formats!"
wal --cols16 -i "$walldir/bg.jpg"
for target in "decor/waybar" "utils/wofi" "decor/wlogout"; do
  cp "$HOME/.cache/wal/colors-waybar.css" "$dotsroot/$target/colors.css"
done
cp "$HOME/.cache/wal/colors-hyprland.conf" "$dotsroot/decor/hypr/"
cp "$HOME/.cache/wal/colors-kitty.conf" "$dotsroot/utils/kitty/colors.conf"
cp "$HOME/.cache/wal/colors-alacritty.toml" "$dotsroot/utils/alacritty/colors.toml"
cat "$dotsroot/decor/hypr/colors-hyprland.conf" "$dotsroot/decor/hypr/hyprtoolkitstat.conf" >"$dotsroot/hypr/hyprtoolkit.conf"
mv "$HOME/temp" "$dotsroot/decor/hypr/hyprtoolkit.conf"
sed -i 's/1\.0/0\.7/g' "$dotsroot/decor/hypr/hyprtoolkit.conf"
sleep 0.1
killall -SIGUSR2 waybar
sleep 0.1
hyprctl hyprpaper reload ,"$walldir/bg.jpg"
echo "Done! Automatically Closing in 3 seconds."
sleep 2
exit 0
