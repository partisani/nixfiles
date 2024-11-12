{ lib, config, ... }:

with lib;

let cfg = config.machine.wm.hyprland; in
{
  options.machine.wm.hyprland = {
    settings = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = {
    programs.hyprland.enable = true;

    machine.home.wayland.windowManager.hyprland = {
      enable = true;
      settings = cfg.settings;
    };
  };
}
