{ lib, config, ... }:

with lib;

let cfg = config.machine; in
{
  options.machine = {
    hostname = mkOption {
      type = types.str;
      default = "please-change-this-right-now";
    };
  };
  
  config = {
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

    networking.hostName = cfg.hostname;
    networking.networkmanager.enable = true;
    
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  };
}
