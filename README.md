# Dots

## NOTICE

PLEASE Do Not attempt to use Install.sh before you have a working sudo config.

These are tested to work on Arch Linux and NixOS ONLY. They will Most likely work on all other distros.

For other distros, see [Other Distros](#other-distributions)

##  Intro

Welcome to my dotfiles! Take whatever you like, but here are a few suggestions:

Use your own wallpaper.
Simply move into `~/dots/wallpaper` and run a quick `home-manager switch --flake ~/dots`.

Modify decor/hypr/monitors.lua to suit your own monitor.

I have a 165hz 1440p, but that's kinda niche.

There's a placeholder so it will work out of the box but you should probably customize it to fit your monitors

## Install
### Arch Linux
You need to have sudo installed for the script to work.

(To be clear, it doesn't run as root, but it needs sudo for package management.)

You can use
```bash
curl -sS https://raw.githubusercontent.com/rvsfirecreeper/dots/refs/heads/main/install.sh ; cat install.sh ; read ; bash install.sh
```
for Arch Linux.

The script isn't long, so I force you to read it ;)
Afterwards, make sure to set waypaper to either dots/wallpaper or ~/.wallpaper(either works)
### NixOS
DO NOT TOUCH the fullSystem option.

It is MY SYSTEM, will create MY USER, and install MY PACKAGES

It will add my user, and is intended for one awesome person(if I do say so myself): Me.

Simply add the Dotfiles to flake.nix with:
```nix
{
  inputs = {
    dots = {
      url = "github:rvsfirecreeper/dots";
    };
  };
  outputs = { nixpkgs, home-manager, dots, ... }:
  {
    nixosConfigurations = {
      whateverYouCallYourSystem = nixpkgs {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.users.ragef = dots.homeManagerModules.default;
            home-manager.backupFileExtension = "bak";
          }
        ];
      };
    };
  };
}
```
Non-flake installation is unsupported.

Other arches might work? I have no way to test and I'm FAR too lazy to check so Here Be Dragons.

PLEASE Replace whateverYouCallYourSystem and yourUsernameHere and make sure to keep your existing stuff DO NOT be an idiot PLEASE.
Way too many people copy-paste and get surprised when ChatGPT points out they don't import configuration.nix.
### Other Distributions
I expect you to be competent if you are doing this.

You can mostly just replace the commands in install.sh and install that way.

You are not officially supported if you do this, but I wish you the best of luck and will help as best I can.
## Preview

[![Showcase](https://raw.githubusercontent.com/rvsfirecreeper/dots/main/showcase.png)](https://raw.githubusercontent.com/rvsfirecreeper/dots/main/showcase.mp4)
