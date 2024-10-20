{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ## game tools ##
    wine64
    winetricks
    protonup
    dxvk
    vulkan-tools
    lutris
    qbittorrent # you know why
    gamescope
    gamemode

    ## minecraft java versions ##
    temurin-bin-8
    temurin-bin-17
    graalvm-ce

    ## emulator & cores ##
    (retroarch.override {
        cores = with libretro; [
            beetle-saturn
        ];
    })

    ## games ##
    nethack
    mindustry
    quakespasm
    prismlauncher
    lunar-client
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
