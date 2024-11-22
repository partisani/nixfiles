{ lib, config, ... }:

with lib;

let cfg = config.machine.apps.kitty; in
{
  options.machine.apps.kitty = {
    config = mkOption {
      type = types.attrsOf types.anything;
      default = {};
    };
  };

  config = {
    machine.home.programs.kitty = {
      enable = true;
      settings = cfg.config;
    };
  };
}
