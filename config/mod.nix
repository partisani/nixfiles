{ config, pkgs, nix-colors, ... }:

let
    nix-colors-extras = nix-colors.lib.contrib { inherit pkgs; };
    colorScheme = config.colorScheme;
    palette = colorScheme.palette;
in {
    imports = [
        ags/ags.nix
        hypr/hypr.nix
        emacs/emacs.nix
        ./tofi.nix
        ./kitty.nix
    ];

    colorScheme = builtins.fromTOML (builtins.readFile ./theme.toml);

    xdg.enable = true;

    gtk = {
        enable = true;
        theme = {
            name = "${colorScheme.slug}";
            package = nix-colors-extras.gtkThemeFromScheme {
                scheme = colorScheme;
            };
        };
    };
}
