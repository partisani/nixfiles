{ lib, config, ... }:

with config.scheme;
{
  wm.hyprland.config = {
    decoration = {
      drop_shadow = true;
      "col.shadow" = "rgb(${base07})";
      "col.shadow_inactive" = "rgb(${base04})";
      shadow_offset = "18 18";
      shadow_range = 0;
    };

    general.border_size = 5;
  };

  apps.tofi.config = {
    outline-width = 0;
    border-width = 0;

    num-results = 6;
    result-spacing = 25;

    width = "100%";
    height = "100%";

    padding-top = "20%";
    padding-bottom = "20%";
    padding-left = "20%";
    padding-right = "20%";
  };
}
