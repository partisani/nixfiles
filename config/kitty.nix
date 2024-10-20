{ config, pkgs, ... }:

let
    colorScheme = config.colorScheme;
    palette = colorScheme.palette;
in {
    programs.kitty = {
        enable = true;

        settings = {
            window_padding_width = 25;

            font_size = 10;
            modify_font = "cell_height 150%";

            confirm_os_window_close = 0;

            hide_window_decorations = false;
            wayland_titlebar_color = "background";

            # colors

            foreground = "#${palette.base04}";
            background = "#${palette.base00}";

            # black
            color0 = "#${palette.base00}";
            color8 = "#${palette.base03}";

            # red
            color1  = "#${palette.base08}";
            color9 = "#${palette.base09}";

            # green
            color2  = "#${palette.base0B}";
            color10 = "#${palette.base01}";

            # yellow
            color3  = "#${palette.base0A}";
            color11 = "#${palette.base02}";

            # blue
            color4  = "#${palette.base0D}";
            color12 = "#${palette.base04}";

            # magenta
            color5  = "#${palette.base0E}";
            color13 = "#${palette.base06}";

            # cyan
            color6  = "#${palette.base0C}";
            color14 = "#${palette.base0F}";
            
            # white
            color7  = "#${palette.base05}";
            color15 = "#${palette.base07}";
        };
    };
}
