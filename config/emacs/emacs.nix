{ config, pkgs, ... }:

let
    colorScheme = config.colorScheme;
    palette = colorScheme.palette;
in {
    xdg.configFile.emacs = {
        source = ./.;
        recursive = true;
    };

    xdg.configFile."emacs/base16-autogen-theme.el".text = ''
        (require 'base16-theme)

        (defvar base16-autogen-theme-colors
            '(:base00 "#${palette.base00}" :base01 "#${palette.base01}" :base02 "#${palette.base02}" :base03 "#${palette.base03}"
              :base04 "#${palette.base04}" :base05 "#${palette.base05}" :base06 "#${palette.base06}" :base07 "#${palette.base07}"
              :base08 "#${palette.base08}" :base09 "#${palette.base09}" :base0A "#${palette.base0A}" :base0B "#${palette.base0B}"
              :base0C "#${palette.base0C}" :base0D "#${palette.base0D}" :base0E "#${palette.base0E}" :base0F "#${palette.base0F}")
              "All colors for this Base16 auto generated theme are defined here.")

       ;; Define the theme
       (deftheme base16-autogen)

       ;; Add all the faces to the theme
       (base16-theme-define 'base16-autogen base16-autogen-theme-colors)

       ;; Mark the theme as provided
       (provide-theme 'base16-autogen)

       (provide 'base16-autogen-theme)
    '';
}
