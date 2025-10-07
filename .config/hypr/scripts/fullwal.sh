#!/bin/zsh
walldir="$HOME/.config/hypr/wallpaper"
read "?Which wallpaper?(or ls to list) " wall
wall="${wall/#\~/$HOME}"
if [ "$wall" = "ls" ]; then
	ls "$walldir"
	sleep 2
	exit 0
elif [ -f "$wall" ]; then
	if ! [[ "${wall##*.}" =~ ^(jpg|jpeg|png|webp|svg)$ ]]; then
	    echo "Not an image. "
	    sleep 2
	    exit 1
	fi
	read -p "New wallpaper detected. What would you like the shorthand to be? Do not include file extensions. " shorthand
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
	echo "Previewing, press q to continue."
	sleep 1
	swayimg "$walldir/$shorthand.jpg"
	read -p "Would you like to switch or not(y/n)" confirm
	if [ "$confirm" = "y" ]; then
		cp "$walldir/$shorthand.jpg" "$walldir/bg.jpg"
	fi
elif [ -f "$walldir/$wall.jpg" ]; then 
	cp "$walldir/$wall.jpg" "$walldir/bg.jpg"
else
	echo "Exiting, no file found. Did you use the shorthand you set when importing? "
	echo "Here are the current wallpapers."
	ls "$walldir"
	sleep 3
	exit 1
fi
echo "Switching to the new wallpaper at .config/hypr/wallpaper/bg.jpg Note: Use magick to convert image formats!"
wal --cols16 -i "$walldir/bg.jpg"
cp "$HOME/.cache/wal/colors-hyprland.conf" "$HOME/.config/hypr/"
cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/waybar/colors.css"
cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/wofi/colors.css"
cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/wlogout/colors.css"
sleep 0.1
killall -SIGUSR2 waybar
pywalfox update
hyprctl hyprpaper reload ,"$walldir/bg.jpg"
echo "Done! Automatically Closing in 3 seconds."
sleep 2
exit 0
