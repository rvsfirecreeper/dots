#!/bin/zsh
walldir="$HOME/dots/hypr/wallpaper"
read "?Which wallpaper?(or ls to list already imported) (You can enter a full path(tildes allowed) to import a new one) " wall
wall="${wall/#\~/$HOME}"
if [ "$wall" = "ls" ]; then
	ls "$walldir"
	sleep 2
	read "?Which wallpaper, now that you have all the options? " wall
	wall="${wall/#\~/$HOME}"
fi
if [ -e "$wall" ]; then
	echo "New Wallpaper Detected! Previewing, press q to continue."
	pqiv "$wall"
	read "?What would you like the shorthand to be? Do not include file extensions. " shorthand
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
	(cd "$HOME/dots" && dotter deploy --force)
	echo "New Wallpaper Detected! Previewing, press q to continue."
	sleep 1
	read "?Would you like to switch or not(y/n)" confirm
	if [ "$confirm" = "y" ]; then
		exit 0
	else
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
echo "Switching to the new wallpaper at dots/hypr/wallpaper/bg.jpg Note: Use magick to convert image formats!"
wal --cols16 -i "$walldir/bg.jpg"
for target in waybar wofi wlogout; do
    cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/dots/$target/colors.css"
done
cp "$HOME/.cache/wal/colors-hyprland.conf" "$HOME/dots/hypr/"
cp "$HOME/.cache/wal/colors-kitty.conf" "$HOME/dots/kitty/colors.conf"
cat "$HOME/dots/hypr/colors-hyprland.conf" "$HOME/dots/hypr/hyprtoolkitstat.conf" > "$HOME/temp"
mv "$HOME/temp" "$HOME/dots/hypr/hyprtoolkit.conf"
sed -i 's/1\.0/0\.7/g' "$HOME/dots/hypr/hyprtoolkit.conf"
sleep 0.1
killall -SIGUSR2 waybar
pywalfox update
hyprctl hyprpaper reload ,"$walldir/$wall.jpg"
echo "Done! Automatically Closing in 3 seconds."
sleep 2
exit 0
