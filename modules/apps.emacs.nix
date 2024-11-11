{ lib, config, pkgs, ... }:

with lib;

let cfg = config.machine.apps.emacs; in {
    options.machine.apps.emacs = {
        config = mkOption {
            type = types.path;
            default = null;
        };
    };
    
    config = {
        services.emacs.enable = true;
        services.emacs.package = pkgs.emacs30;
        
        machine.home.xdg.configFile.emacs = {
            source = cfg.config;
            recursive = true;
        };
    };
}
