{ config, lib, pkgs, modulesPath, ... }:

# Hardware configuration
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
    
    fileSystems = {
        "/" = {
            device = "/dev/disk/by-uuid/cc991b5a-b6e2-4ec1-98e1-3b0568c00c87";
            fsType = "ext4";
        };
        
        "/boot" = {
            device = "/dev/disk/by-uuid/FF51-7E63";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
        };
    };

    swapDevices = [ { device =
        "/dev/disk/by-uuid/f07f68e1-877b-46be-95f0-69587b1aac8a"; } ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
