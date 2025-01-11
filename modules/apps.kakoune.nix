{ lib, config, pkgs, ... }:

with lib;

let cfg = config.machine.apps.kakoune; in
{
    options.machine.apps.kakoune = {
        config = mkOption {
            type = types.path;
            default = null;
        };
    };

    config = {
        machine.home = {
            xdg.configFile.kak = {
                source = cfg.config;
                recursive = true;
            };

            programs.kakoune = {
                enable = true;
                config = null;
            };
        };

        environment.systemPackages = with pkgs; [ kakoune-lsp ];
    };
}
