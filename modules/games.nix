{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # Minecraft
        prismlauncher
        lunar-client
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21

        mindustry

        qbittorrent
    ];

    
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.steam = {
        enable = true;
        
        # Firewall
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
    };
}
