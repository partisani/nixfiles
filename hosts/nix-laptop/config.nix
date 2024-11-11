{ config, lib, pkgs, inputs, modulesPath, ... }:

{
    imports = with inputs.modules; [
        # Most modules can be imported just by their path
        # but some, that take arguments, need to be imported first,
        # then the arguments need to be passed.
        
        # You may be asking yourself: Why?
        # My answer: i don't want to add another level of nesting
        # just for a single value (username)
        
        # This solution may not be optimal for some modules, like
        # the emacs one, so i will just add them to `machine` instead.
        
        # Just to make configuration cleaner, i moved a lot of
        # the things that should be the same for every host inside
        # of this module.
        default
        
        # (Multi) language settings
        locale
    
        # Create user and set up home-manager.
        home
        
        # Enable window managers/desktop environments.
        wm
        wm-niri
        wm-hyprland
        
        # Iosevka is a good font
        fonts-iosevka
        
        # Install a few apps.
        apps-kitty
        apps-emacs
        
        # Fun and games.
        games
    ];
    
    machine = {
        hostname = "nix-laptop";
        
        user = {
            name = "partisani";
            description = "Isaac";
        };
        
        home = {
            home.file."randomfile.txt".text = "cryobout it";
        };
        
        locale = {
            language = "en_US.UTF-8";
            alternateLanguage = "pt_BR.UTF-8";
            timeZone = "America/Bahia";
            layout = "br";
        };
        
        apps = {
            emacs.config = ./emacs;
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

    system.stateVersion = "24.05"; # Did you read the comment?
}
