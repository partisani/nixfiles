{ lib, config, pkgs, ... }:

with config.scheme;
{
  wm.hyprland.config = {
    general = {
      gaps_in = 5;
      gaps_out = 20;
    };

    exec-once =
      let
        vim-bar = pkgs.writeScript "vim-bar" "
          #!${pkgs.nushell}/bin/nu
          def bar-command [] {
              let width = (term size).columns
              let workspaces = (hyprctl workspaces -j | from json)

              let text = workspaces
              | each {|e| $e.name}
              | str join \" \"
              | fill -w $width -a r

              $\"tput civis; printf \"$text\r\"; sleep 10sec\"
          }

          kitty +kitten panel -o window_padding_width=3 -o font_size=9 -o background=#${base07} -o foreground=#${base00} --lines 1 --edge bottom nu -c (bar-command)'
        ";
      in
        [
          "${vim-bar}"
        ];
  };
}
