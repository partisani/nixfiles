{ config, lib, pkgs, inputs, modulesPath, ... }:

{
    imports = with inputs.modules; [
        # Create user and set up home-manager.
        (import home { username = "partisani"; })
        
        # Enable window managers/desktop environments.
        wm wm-niri wm-hyprland
        
        games
    ];
    
    machine = {
        home = {
            home.file."randomfile.txt".text = "cryobout it";
        };
    };

    boot.loader.systemd-boot.enable = false;
    boot.loader = {
        grub = {
            enable = true;
            device = "nodev";
            useOSProber = true;
            efiSupport = true;
            efiInstallAsRemovable = true;
        };
    };

    networking.hostName = "nix-laptop";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Bahia";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_BR.UTF-8";
        LC_IDENTIFICATION = "pt_BR.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NAME = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
        LC_PAPER = "pt_BR.UTF-8";
        LC_TELEPHONE = "pt_BR.UTF-8";
        LC_TIME = "pt_BR.UTF-8";
    };

    services.xserver.xkb.layout = "br";
    console.keyMap = "br-abnt2";

    services.printing.enable = true;

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    programs.firefox.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.systemPackages = with pkgs; [
        git
        ani-cli
        
        kitty
    ];

    system.stateVersion = "24.05"; # Did you read the comment?
}
