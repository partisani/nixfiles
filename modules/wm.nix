{ ... }:

{
    services.xserver.enable = true;

    # I don't plan on using another session manager.
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
}
