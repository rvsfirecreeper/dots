{ pkgs, ... }:
{
  home.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    floorp-bin
    rustup
    prismlauncher
    gcc
    tree
    zed-editor
    wl-clipboard
    steam
    yubikey-manager
    yubikey-personalization
    keepassxc
    nil
  ];
}
