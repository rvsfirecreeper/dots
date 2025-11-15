
# Dots

## NOTICE

These dotfiles rely on Pywal16 heavily. Not pywal, pywal16

These dotfiles are also extremely likely to error out except on artix with runit.
DO NOT USE ON ARCH LINUX WITHOUT MODIFICATIONS.

## PLEASE Do Not attempt to use anything from here before

* Installing pywal16
* running fullwal.sh(.config/hypr/scripts/fullwal.sh)
These are also hardcoded for my monitors, please change the following:
* `~/.config/hypr/scripts/fullwal.sh`
* `~/.config/hypr/hyprpaper.conf`
If your distro does not show up automatically in the prompt, add it to ~/.config/starship.toml

---

Welcome to my dotfiles! Take whatever you like, but here are a few suggestions:

Use your own wallpaper.
I have a script for this that can import wallpapers into the folder for future use.

Modify monitors.conf to suit your own monitor.
I have a 165hz 1440p, but that's kinda niche.

## Install

You can use
`curl -sS https://gitlab.com/coolrustcoderguy/dots/-/raw/main/install.sh | bash`
for Artix, Arch, etc.

Or manually install all dependencies and use dotter deploy

## Note for Artix users

I'm too lazy to check but you probably need the extra repo enabled at minimum

## Dependencies

(This list is outdated, just check install.sh for up-to-date deps)

## Shells/Terminal

`bash`
`kitty`
`starship`
`zsh`

## Hypr Ecosystem

`hypridle`
`hyprland`
`hyprlock`
`hyprpaper`
`hyprpolkitagent`
`hyprsunset`

## Pywal/Wallpaper/Fullwal.sh

`imagemagick`(Substitutable with `graphicsmagick`)
`pywal16`
`pqiv`

## Utilities

`opendoas`(see Doas)
`nvim`
`paru`(needed for install)(also just use an AUR Helper bro you're not cool)
`dotter`(Needed for install, you can copy dotfiles but I highly recommend dotter,
it's pretty cool!)
`swaync`
`waybar`
`wofi`
`wlogout`

## Doas

OpenDoas is recommended. My zshrc breaks sudo, so you must use an alternative.
It aliases sudo to `doasi.....awufhaespofihjewd`, which will break sudo.

## Screenshots

![Screenshot](screenshots/screenshot1.png)
![Screenshot](screenshots/screenshot2.png)
![Screenshot](screenshots/screenshot3.png)
![Screenshot](screenshots/screenshot4.png)
![Screenshot](screenshots/screenshot5.png)
![Screenshot](screenshots/screenshot6.png)
