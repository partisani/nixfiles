{ config, pkgs, lib, ... }:

{
    imports = [
        ./modules/mod.nix
        ./hardware-configuration.nix
    ];

    boot.kernelPackages = with pkgs; linuxPackages_zen;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    users.groups.uinput = {};
    users.users.partisani = {
        isNormalUser = true;
        description = "Isaac";
        extraGroups = [ "networkmanager" "wheel" "input" "uinput" "video" ];
        shell = pkgs.nushell;
    };

    home-manager.backupFileExtension = "bak";

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.variables = {
        EDITOR = "kak";
        VISUAL = "kak";
        TERMINAL = "kitty";
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
            "/home/partisani/.steam/root/compatibilitytools.dv";
    };

    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
        firefox
        unp
        yazi
        ani-cli
        ntfs3g
        btrfs-progs
        dust
        nh
        linuxKernel.packages.linux_zen.perf
        lmms
        (pkgs.discord.override {
            withVencord = true;
        })
        comma
        puredata

        httplz
    ];

    systemd.services.homepageServer = {
        wantedBy = [ "graphical.target" ];

        after = [ "network.target" ];
        description = "Start the homepage http server for partisani.";

        serviceConfig = {
            Type = "simple";
            User = "partisani";
            ExecStart = ''${pkgs.httplz}/bin/httplz -p 8079 /home/partisani/.config/misc/'';
            ExecStop = ''${pkgs.procps}/bin/pkill httplz'';
        };
    };

    system.stateVersion = "23.11";
}
