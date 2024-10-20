{ config, pkgs, nix-colors, ... }:

{
    imports = [
        ./config/mod.nix
        nix-colors.homeManagerModules.default
    ];

    home.username = "partisani";
    home.homeDirectory = "/home/partisani";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
