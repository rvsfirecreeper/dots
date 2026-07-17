{ config, pkgs, ... }:

let
  theme = {
    home = config.home.homeDirectory;

    font = "JetBrainsMono Nerd Font";
    font_size = "13";
    large_font_size = "20";

    opacity_float = 0.7;
    opacity = toString (theme.opacity_float);
    opacity_percent = toString ( builtins.floor (theme.opacity_float * 100));

    is_pill = "true";
    terminal = "wezterm";
  };

  template = path:
    let
      text = builtins.readFile path;
      keys = builtins.attrNames theme;
      values = builtins.attrValues theme;
    in
      builtins.replaceStrings
        (map (x: "{{${x}}}") keys)
        values
        text;

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
    (normalFile ".profile" ./shell/profile //
    normalFile ".zshrc" ./shell/zshrc //
    normalFile ".bashrc" ./shell/bashrc //

    normalFile ".config/fish/config.fish" ./shell/config.fish //
    normalFile ".config/nushell" ./shell/nushell //

    normalFile ".config/fastfetch" ./eyecandy/fastfetch //
    normalFile ".config/starship.toml" ./eyecandy/starship.toml //

    normalFile ".config/wallust/templates" ./eyecandy/wallust/templates //

    normalFile ".config/hypr/binds.lua" ./core/hypr/binds.lua //
    normalFile ".config/hypr/daemons.lua" ./core/hypr/daemons.lua //
    normalFile ".config/hypr/input.lua" ./core/hypr/input.lua //
    normalFile ".config/hypr/layouts.lua" ./core/hypr/layouts.lua //
    normalFile ".config/hypr/looks.lua" ./core/hypr/looks.lua //
    normalFile ".config/hypr/perms.lua" ./core/hypr/perms.lua //
    normalFile ".config/hypr/monitors.lua" ./core/hypr/monitors.lua //
    normalFile ".config/hypr/windowRules.lua" ./core/hypr/windowRules.lua //
    normalFile ".config/quickshell/Lock.qml" ./core/quickshell/Lock.qml //
    normalFile ".config/quickshell/Bar.qml" ./core/quickshell/Bar.qml //
    normalFile ".config/quickshell/Bar" ./core/quickshell/Bar //

    normalFile ".config/kanata" ./utils/kanata //
    normalFile ".config/btop/btop.conf" ./utils/btop/btop.conf //
    normalFile ".config/wofi/config" ./utils/wofi/config //
    normalFile ".config/helix" ./utils/helix //

    normalFile ".scripts" ./scripts //

    normalFile ".wallpaper" ./wallpaper //

    # Templated files
    templateFile ".config/wofi/style.css"
      ./utils/wofi/style.css //

    templateFile ".config/waypaper/style.css"
      ./eyecandy/waypaper/style.css //

    templateFile ".config/hypr/hyprland.lua"
      ./core/hypr/hyprland.lua //

    templateFile ".config/quickshell/Theme.qml"
      ./core/quickshell/Theme.qml //

    templateFile ".config/wezterm/wezterm.lua"
      ./core/wezterm/wezterm.lua //

    templateFile ".config/wallust/wallust.toml"
      ./eyecandy/wallust/wallust.toml
    );


  programs.home-manager.enable = true;
}
