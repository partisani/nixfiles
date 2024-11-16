{ lib, config, pkgs, ... }:

with lib;

let cfg = config.machine.apps.emacs; in
{
  options.machine.apps.emacs = {
    config = mkOption {
      type = types.path;
      default = null;
    };
  };
  
  config = {
    services.emacs.enable = true;
    services.emacs.package = pkgs.emacs30;
    
    machine.home.xdg.configFile = {
      emacs = {
        source = cfg.config;
        recursive = true;
      };
      
      "emacs/base16-autogen-theme.el".text = with config.scheme.withHashtag; ''
          (require 'base16-theme)

          (defvar base16-autogen-theme-colors
              '(:base00 "${base00}" :base01 "${base01}" :base02 "${base02}" :base03 "${base03}"
                :base04 "${base04}" :base05 "${base05}" :base06 "${base06}" :base07 "${base07}"
                :base08 "${base08}" :base09 "${base09}" :base0A "${base0A}" :base0B "${base0B}"
                :base0C "${base0C}" :base0D "${base0D}" :base0E "${base0E}" :base0F "${base0F}")
                "All colors for this Base16 auto generated theme are defined here.")

         ;; Define the theme
         (deftheme base16-autogen)

         ;; Add all the faces to the theme
         (base16-theme-define 'base16-autogen base16-autogen-theme-colors)

         ;; Mark the theme as provided
         (provide-theme 'base16-autogen)

         (provide 'base16-autogen-theme)
      '';
    };
  };
}