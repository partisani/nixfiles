{ lib, config, pkgs, ... }:

with lib;

let cfg = config.machine.shells.nushell; in
{
  options.machine.shells.nushell = {
    config = mkOption {
      type = types.path;
      default = null;
    };
  };
  
  config = {
    users.defaultUserShell = pkgs.nushell;

    machine.home.xdg.configFile.nushell = {
      source = cfg.config;
      recursive = true;
    };
  };
}