{
  description = "RajLab Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      homeManagerModules.default = ./dots.nix;
      homeManagerModules.fullSystem = {
        imports = [
          ./dots.nix
          ./nixos-config/home.nix
        ];
      };
      homeConfigurations = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ./dots.nix

          {
            home.username = builtins.getEnv "USER";
            home.homeDirectory = builtins.getEnv "USER";
          }
        ];
      };
    };
}
