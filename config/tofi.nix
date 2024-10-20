{ config, pkgs, ... }:

let
    colorScheme = config.colorScheme;
    palette = colorScheme.palette;
in {
    programs.tofi = {
        enable = true;
        settings = {
            num-results = 6;
            prompt-text = "run: ‎";

            # style

            width = "100%";
            height = "100%";

            border-width = 0;
            outline-width = 0;

            padding-left = "30%";
            padding-top = "22%";

            result-spacing = 30;
            text-cursor = true;

            font = "Monospace Black";
            font-size = 16;

            text-color = palette.base04;
            prompt-color = palette.base07;
            selection-color = palette.base00;
            selection-background = palette.base07;
            selection-background-padding = 15;

            background-color = "#${palette.base00}77";
        };
    };
}
