{ config, lib, pkgs, inputs, modulesPath, ... }@args :

{
  imports = with inputs.modules; [
    # Just to make configuration cleaner, i moved a lot of
    # the things that should be the same for every host inside
    # of this module.
    default

    # (Multi) language settings
    locale
    
    # Create user and set up home-manager.
    home

    # A module for colors.
    colors
    
    # Nushell, my configuration depends on it
    shells-nushell
    
    # Enable window managers/desktop environments.
    wm
    # wm-niri
    wm-hyprland
    wm-river
    
    # Iosevka is a good font
    fonts-iosevka
    
    # Development
    dev-rust
    dev-c
    dev-lua
    dev-godot

    # Install a few apps.
    apps-gowall
    apps-tofi
    apps-kitty
    apps-emacs
    apps-kakoune
    
    # Fun and games.
    games
  ];

  scheme = "${inputs.base16-schemes}/base16/hardcore.yaml";
  
  machine = inputs.utils.lib.recursiveMerge
    [
      {
        hostname = "nix-laptop";
        
        locale = {
          language = "en_US.UTF-8";
          alternateLanguage = "pt_BR.UTF-8";
          timeZone = "America/Bahia";
          layout = "br";
        };

        user = {
          name = "partisani";
          description = "Isaac";
        };
        
        shells.nushell.config = ./nushell;
        
        wm = {
          hyprland.config = import ./hyprland.nix args;
          river.config = import ./river.nix args;
        };
        
        apps = {
          gowall.colors = config.scheme.toList
            |> builtins.map (h: "#" + h);
          tofi.config = import ./tofi.nix args;
          kitty.config = import ./kitty.nix args;
          emacs.config = ./emacs;
          kakoune.config = ./kakoune;
        };

        home = {
          gtk.font.name = "IosevkaHomemade Nerd Font Extended";
        };
      }
      (import ./themes/round-paper.nix args) # Theme
    ];

  # Iosevka is a good font
  fonts.fontconfig.defaultFonts = {
    monospace = [ "IosevkaHomemade Nerd Font Extended" ];
    serif = ["Iosevka Aile"];
    sansSerif = ["Iosevka Aile"];
  };

  services.printing.enable = true;

  programs.firefox.enable = true;

  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    git
    totp-cli
    
    ani-cli
    komikku
    
    swaybg

    nh
    nixfmt-rfc-style

    anydesk
    
    obsidian

    lmms
    krita
  ];

  system.stateVersion = "24.05";
}
