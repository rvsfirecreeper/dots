{ config, pkgs, lib, ... }:
let
  # user facing options
  options = {
    opacity = 0.95;
    font_size = 13;
    large_font_size = 20;
    font = "JetBrainsMono Nerd Font";
    solid_bar = true;
    # catppuccin flavors for dark/light mode (latte, frappe, macchiato, mocha); toggle at runtime with scripts/walmode.sh
    dark_flavor = "mocha";
    light_flavor = "latte";
  };
  # catppuccin colors, templated into everything in ./colorfiles
  palettes = import ./colorfiles/palettes.nix;
  hexOf = lib.removePrefix "#";
  # all color keys for one flavor
  colorKeysFor =
    flavor: isLight:
    let
      palette = palettes.${flavor};
    in
    palette
    // lib.mapAttrs' (n: v: lib.nameValuePair "${n}_hex" (hexOf v)) palette
    // (with palette; {
      # Terminal slots, using the standard Catppuccin ANSI mapping
      background = base;
      foreground = text;
      cursor = rosewater;
      color0 = surface1; color1 = red; color2 = green; color3 = yellow;
      color4 = blue; color5 = pink; color6 = teal; color7 = subtext1;
      color8 = surface2; color9 = red; color10 = green; color11 = yellow;
      color12 = blue; color13 = pink; color14 = teal; color15 = subtext0;
    })
    // {
      inherit flavor;
      flavor_title = lib.toUpper (builtins.substring 0 1 flavor) + builtins.substring 1 (-1) flavor;
      appearance = if isLight then "light" else "dark";
      jb_parent = if isLight then "Default" else "Darcula";
    };
  # {{mix a b p}} -> "#rrggbb" blending p% of b into a, {{mix_hex a b p}} -> "rrggbb"
  channels = hex: map (i: lib.fromHexString (builtins.substring i 2 (hexOf hex))) [ 0 2 4 ];
  hex2 = n: let s = lib.toLower (lib.toHexString n); in if builtins.stringLength s < 2 then "0${s}" else s;
  mixColors = a: b: p:
    lib.concatStrings (lib.zipListsWith (x: y: hex2 ((x * (100 - p) + y * p + 50) / 100)) (channels a) (channels b));
  applyMix = palette: text:
    lib.concatStrings (map
      (part:
        if builtins.isString part then part
        else
          let
            kind = builtins.elemAt part 0;
            mixed = mixColors palette.${builtins.elemAt part 1} palette.${builtins.elemAt part 2} (lib.toInt (builtins.elemAt part 3));
          in
          if kind == "mix_hex" then mixed else "#${mixed}")
      (builtins.split "[{][{](mix_hex|mix) ([a-z0-9]+) ([a-z0-9]+) ([0-9]+)[}][}]" text));

  theme = {
    home = config.home.homeDirectory;
    font_size = toString (options.font_size);
    large_font_size = toString (options.large_font_size);
    font = options.font;
    opacity = toString (options.opacity);
    opacity_percent = toString (builtins.floor (options.opacity * 100));

    is_pill = if options.solid_bar then "true" else "false";
    terminal = "kitty";
  };
  templateFlavor =
    flavor: isLight: path:
    let
      text = builtins.readFile path;
      all = theme // colorKeysFor flavor isLight;
      keys = builtins.attrNames all;
      values = builtins.attrValues all;
    in
    applyMix palettes.${flavor} (builtins.replaceStrings (map (x: "{{${x}}}") keys) values text);
  # for files that use no color keys
  template = templateFlavor options.dark_flavor false;

  templateFile = target: source: {
    name = target;
    value = {
      text = template source;
    };
  };

  # Every themed file, rendered for both flavors. They live under ~/.local/share/dots/colors/{dark,light}
  # and scripts/walmode.sh links the active mode into place, so toggling needs no rebuild.
  colorTargets = [
    { target = ".config/quickshell/Colors.qml"; source = ./colorfiles/colors.qml; }
    { target = ".config/hypr/colors.lua"; source = ./colorfiles/colors.lua; }
    { target = ".config/kitty/colors.conf"; source = ./colorfiles/kitty.conf; }
    { target = ".config/btop/themes/catppuccin.theme"; source = ./colorfiles/btop.theme; }
    { target = ".config/wofi/colors.css"; source = ./colorfiles/colors.css; }
    { target = ".config/waypaper/colors.css"; source = ./colorfiles/colors.css; }
    { target = ".themes/catppuccin/gtk-3.0/gtk.css"; source = ./colorfiles/gtk.css; }
    { target = ".config/wezterm/colors/catppuccin.toml"; source = ./colorfiles/wezterm.toml; }
    { target = ".config/zed/themes/catppuccin.json"; source = ./colorfiles/zed.json; }
    { target = ".config/niri/layout.kdl"; source = ./colorfiles/niri.kdl; }
    { target = ".jetbrains.icls"; source = ./colorfiles/jetbrains.icls; }
  ];
  colorFiles = lib.concatMap (
    { mode, flavor, isLight }:
    map (
      { target, source }:
      {
        name = ".local/share/dots/colors/${mode}/${target}";
        value.text = templateFlavor flavor isLight source;
      }
    ) colorTargets
  ) [
    { mode = "dark"; flavor = options.dark_flavor; isLight = false; }
    { mode = "light"; flavor = options.light_flavor; isLight = true; }
  ];
  normalFile = target: source: {
    name = target;
    value = {
      source = source;
    };
  };

in
{
  home.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    awww
    swayidle
    swaynotificationcenter
    git
    quickshell
    yazi
    kitty
    zoxide
    wofi
    fastfetch
    starship
    kanata
    bibata-cursors
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
  ];
  home.file = builtins.listToAttrs ([
    # good old files
    (normalFile ".profile" ./shell/profile)
    (normalFile ".zshrc" ./shell/zshrc)
    (normalFile ".bashrc" ./shell/bashrc)
    (normalFile ".config/fish/config.fish" ./shell/config.fish)
    (normalFile ".config/nushell" ./shell/nushell)
    (normalFile ".config/fastfetch" ./eyecandy/fastfetch)
    (normalFile ".config/starship.toml" ./eyecandy/starship.toml)
    (normalFile ".config/hypr/binds.lua" ./core/hypr/binds.lua)
    (normalFile ".config/hypr/daemons.lua" ./core/hypr/daemons.lua)
    (normalFile ".config/hypr/input.lua" ./core/hypr/input.lua)
    (normalFile ".config/hypr/layouts.lua" ./core/hypr/layouts.lua)
    (normalFile ".config/hypr/looks.lua" ./core/hypr/looks.lua)
    (normalFile ".config/hypr/perms.lua" ./core/hypr/perms.lua)
    (normalFile ".config/hypr/monitors.lua" ./core/hypr/monitors.lua)
    (normalFile ".config/hypr/windowRules.lua" ./core/hypr/windowRules.lua)
    (normalFile ".config/quickshell/Lock.qml" ./core/quickshell/Lock.qml)
    (normalFile ".config/quickshell/Bar.qml" ./core/quickshell/Bar.qml)
    (normalFile ".config/quickshell/Bar" ./core/quickshell/Bar)
    (normalFile ".config/kanata" ./utils/kanata)
    (normalFile ".config/btop/btop.conf" ./utils/btop/btop.conf)
    (normalFile ".config/wofi/config" ./utils/wofi/config)
    (normalFile ".config/helix" ./utils/helix)
    (normalFile ".ideavimrc" ./utils/ideavimrc) 
    (normalFile ".scripts" ./scripts)
    (normalFile ".wallpaper" ./wallpaper)
    # Templated files
    (templateFile ".config/wofi/style.css" ./utils/wofi/style.css)
    (templateFile ".config/kitty/kitty.conf" ./core/kitty/kitty.conf)
    (templateFile ".config/waypaper/style.css" ./eyecandy/waypaper/style.css)
    (templateFile ".config/hypr/hyprland.lua" ./core/hypr/hyprland.lua)
    (templateFile ".config/quickshell/Theme.qml" ./core/quickshell/Theme.qml)
  ] ++ colorFiles);
  # Link the active (dark/light) color files into place after every switch.
  home.activation.colorMode = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -z "''${DRY_RUN:-}" ]; then
      NORELOAD=1 $HOME/.scripts/walmode.sh apply
    fi
  '';
  programs.home-manager.enable = true;
}
