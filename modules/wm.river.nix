{ lib, config, ... }:

with lib;

let cfg = config.machine.wm.river; in
{
  options.machine.wm.river = {
    config = mkOption {
      type = types.attrsOf types.anything;
      default = {};
    };
  };

  config = {
    programs.river.enable = true;
  };
}
