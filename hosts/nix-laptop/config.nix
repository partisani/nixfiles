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

    # Theme
    ./themes/paper.nix
    
    # Nushell, my configuration depends on it
    shells-nushell
    
    # Enable window managers/desktop environments.
    wm
    # wm-niri
    wm-hyprland
    
    # Iosevka is a good font
    fonts-iosevka
    
    # Development
    dev-rust

    # Install a few apps.
    apps-tofi
    apps-kitty
    apps-emacs
    
    # Fun and games.
    games
  ];

  scheme = "${inputs.base16-schemes}/base16/heetch-light.yaml";
  
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
    
    shells.nushell.config = ./nushell;
    
    wm.hyprland.config = import ./hyprland.nix args;
    
    apps = {
      tofi.config = import ./tofi.nix args;
      kitty.config = import ./kitty.nix args;
      emacs.config = ./emacs;
    };
  };

  # Iosevka is a good font
  fonts.fontconfig.defaultFonts = {
    monospace = [ "IosevkaHomemade Nerd Font" ];
    serif = ["Iosevka Aile"];
    sansSerif = ["Iosevka Aile"];
  };
  machine.home.gtk.font.name = "IosevkaHomemade Nerd Font Extended";

  services.printing.enable = true;

  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    git
    ani-cli
    swaybg
    nh
    nixfmt-rfc-style
  ];

  system.stateVersion = "24.05";
}
