{ config, pkgs, ... }:
let
  # user facing options
  options = {
    opacity = 0.7;
    font_size = 13;
    large_font_size = 20;
    font = "JetBrainsMono Nerd Font";
    solid_bar = true;
  };
  theme = {
    boolToString = b: if b then "true" else "false";
    home = config.home.homeDirectory;
    font_size = toString (options.font_size);
    large_font_size = toString (options.large_font_size);
    font = options.font;
    opacity = toString (options.opacity);
    opacity_percent = toString (builtins.floor (options.opacity * 100));

    is_pill = theme.boolToString options.solid_bar;
    terminal = "wezterm";
  };
  template =
    path:
    let
      text = builtins.readFile path;
      keys = builtins.attrNames theme;
      values = builtins.attrValues theme;
    in
    builtins.replaceStrings (map (x: "{{${x}}}") keys) values text;

  templateFile = target: source: {
    "${target}".text = template source;
  };

  normalFile = target: source: {
    "${target}".source = source;
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
    wezterm
    zoxide
    wofi
    waypaper
    fastfetch
    wallust
    starship
    kanata
    bibata-cursors
  ];

  home.file =

    # Normal files
    (
      normalFile ".profile" ./shell/profile
      // normalFile ".zshrc" ./shell/zshrc
      // normalFile ".bashrc" ./shell/bashrc
      //

        normalFile ".config/fish/config.fish" ./shell/config.fish
      // normalFile ".config/nushell" ./shell/nushell
      //

        normalFile ".config/fastfetch" ./eyecandy/fastfetch
      // normalFile ".config/starship.toml" ./eyecandy/starship.toml
      //

        normalFile ".config/wallust/templates" ./eyecandy/wallust/templates
      //

        normalFile ".config/hypr/binds.lua" ./core/hypr/binds.lua
      // normalFile ".config/hypr/daemons.lua" ./core/hypr/daemons.lua
      // normalFile ".config/hypr/input.lua" ./core/hypr/input.lua
      // normalFile ".config/hypr/layouts.lua" ./core/hypr/layouts.lua
      // normalFile ".config/hypr/looks.lua" ./core/hypr/looks.lua
      // normalFile ".config/hypr/perms.lua" ./core/hypr/perms.lua
      // normalFile ".config/hypr/monitors.lua" ./core/hypr/monitors.lua
      // normalFile ".config/hypr/windowRules.lua" ./core/hypr/windowRules.lua
      // normalFile ".config/quickshell/Lock.qml" ./core/quickshell/Lock.qml
      // normalFile ".config/quickshell/Bar.qml" ./core/quickshell/Bar.qml
      // normalFile ".config/quickshell/Bar" ./core/quickshell/Bar
      //

        normalFile ".config/kanata" ./utils/kanata
      // normalFile ".config/btop/btop.conf" ./utils/btop/btop.conf
      // normalFile ".config/wofi/config" ./utils/wofi/config
      // normalFile ".config/helix" ./utils/helix
      //

        normalFile ".scripts" ./scripts
      //

        normalFile ".wallpaper" ./wallpaper
      //

        # Templated files
        templateFile ".config/wofi/style.css" ./utils/wofi/style.css
      //

        templateFile ".config/waypaper/style.css" ./eyecandy/waypaper/style.css
      //

        templateFile ".config/hypr/hyprland.lua" ./core/hypr/hyprland.lua
      //

        templateFile ".config/quickshell/Theme.qml" ./core/quickshell/Theme.qml
      //

        templateFile ".config/wezterm/wezterm.lua" ./core/wezterm/wezterm.lua
      //

        templateFile ".config/wallust/wallust.toml" ./eyecandy/wallust/wallust.toml
    );

  programs.home-manager.enable = true;
}
