{ config, pkgs, pkgs-stable, ... }:

{
    # Why is it xserver?
    services.xserver.enable = true;

    services.kanata = {
        enable = true;
        keyboards.main = {
            devices = [
                "/dev/input/by-id/usb-USB_USB_Keyboard-event-kbd"
            ];

            configFile = resources/kanata.kbd;
        };
    };

    services.displayManager.sddm.enable = true;
    programs.hyprland.enable = true;

    # Enable automatic login for me
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "partisani";
    
    # Automatic login workaround and giving space for a
    # future fantasy console on /dev/tty3 :shrug:
    systemd.services = {
        "getty@tty1".enable = false;
        "autovt@tty1".enable = false;

        "getty@tty3".enable = false;
        "autovt@tty3".enable = false;
    };

    environment.systemPackages = with pkgs; [
        pciutils
        swaybg
        tofi
        ags
        pkgs-stable.cliphist
        wl-clipboard
        hyprshot
        hyprpicker
    ];
}
