{ config, pkgs, ... }:

let
    colorScheme = config.colorScheme;
    palette = colorScheme.palette;
in {
    xdg.configFile.ags = {
        source = ./.;
        recursive = true;
    };

    xdg.configFile."ags/theme.css".text = ''
        @define-color bg-color   #${palette.base00};
        @define-color text-color #${palette.base06}; 
        @define-color alt-color  #${palette.base0C};
    '';
}
