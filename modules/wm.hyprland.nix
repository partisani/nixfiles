{ lib, config, ... }:

with lib;

let cfg = config.machine.wm.hyprland; in
{
  options.machine.wm.hyprland = {
    config = mkOption {
      type = types.attrsOf types.anything;
      default = {};
    };
  };

  config = {
    programs.hyprland.enable = true;

    machine.home.wayland.windowManager.hyprland = {
      enable = true;
      settings = cfg.config;
    };
  };
}
