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
    dev-godot

    # Install a few apps.
    apps-tofi
    apps-kitty
    apps-emacs
    
    # Fun and games.
    games
  ];

  scheme = "${inputs.base16-schemes}/base16/solarized-light.yaml";
  
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
          tofi.config = import ./tofi.nix args;
          kitty.config = import ./kitty.nix args;
          emacs.config = ./emacs;
        };

        home = {
          gtk.font.name = "IosevkaHomemade Nerd Font Extended";

          home.file.".system/commands-hyprland.json".text = (import ./commands.nix {
            name = "hyprland";

            commands = {
              exit = "hyprctl dispatch exit";
            };
            
            term = { name = "kitty"; command = "kitty"; };
            app-launcher = { name = "tofi"; command = "tofi-drun | nu -c $in"; };
          })
          |> builtins.toJSON;
        };
      }
      (import ./themes/vimeous.nix args) # Theme
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
  ];

  system.stateVersion = "24.05";
}
