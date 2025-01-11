{ lib, config, pkgs, ... }:

with lib;

let cfg = config.machine.apps.gowall; in
{
    options.machine.apps.gowall = {
        colors = mkOption {
            type = types.listOf types.str;
            default = [];
        };
    };

    config = {
        machine.home = {
            xdg.configFile."gowall/config.yml".text = (
                { themes = [{ name = "base16"; colors = cfg.colors; }]; EnableImagePreviewing = true; }
            ) |> builtins.toJSON;
        };

        environment.systemPackages = with pkgs; [ gowall ];
    };
}
