{ config, pkgs, ... }:

let
    colorScheme = config.colorScheme;
    palette = colorScheme.palette;
in {
    xdg.configFile.hypr = {
        source = ./.;
        recursive = true;
    };

    xdg.configFile."hypr/theme.conf".text = with palette; ''
        $BgColor = ${base00}
        $TextColor = ${base06}
        $AltColor = ${base0C}
        $ErrColor = ${base08}
    '';
}
