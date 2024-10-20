{ config, pkgs, ... }:

{
  imports = [
    ./networking.nix
    ./locale.nix
    ./desktop-env.nix
    ./fonts.nix
    ./sound.nix
    ./games.nix
    ./dev.nix
  ];
}
