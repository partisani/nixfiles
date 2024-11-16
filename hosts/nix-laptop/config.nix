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

    # A module for colors, probably required for most of the apps.
    colors
    
    # Nushell, my configuration depends on it
    shells-nushell
    
    # Enable window managers/desktop environments.
    wm
    # wm-niri
    wm-hyprland
    
    # Iosevka is a good font
    fonts-iosevka
    
    # Install a few apps.
    apps-tofi
    apps-kitty
    apps-emacs
    
    # Fun and games.
    games
  ];

  scheme = "${inputs.base16-schemes}/base16/katy.yaml";
  
  machine = {
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
    
    home = {
      home.file."home-manager-is-functioning.txt".text =
        "i can guarantee that if this file was generated, then home-manager works.";
    };

    shells.nushell.config = ./nushell;
    
    wm.hyprland.settings = import ./hyprland.nix args;
    
    apps = {
      emacs.config = ./emacs;
      tofi.config = import ./tofi.nix args;
    };
  };

  # Iosevka is a good font
  fonts.fontconfig.defaultFonts = {
    monospace = [ "IosevkaHomemade Nerd Font Extended" ];
    serif = ["Iosevka Aile"];
    sansSerif = ["Iosevka Aile"];
  };

  services.printing.enable = true;

  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    git
    ani-cli
  ];

  system.stateVersion = "24.05"; # Did you read the comment? No, i didn't.
}
