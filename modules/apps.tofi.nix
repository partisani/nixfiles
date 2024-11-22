{ lib, config, ... }:

with lib;

let cfg = config.machine.apps.tofi; in
{
  options.machine.apps.tofi = {
    config = mkOption {
      type = types.attrsOf types.anything;
      default = {};
    };
  };

  config = {
    machine.home.programs.tofi = {
      enable = true;
      settings = cfg.config;
    };
  };
}
