{ lib, inputs, config, ... }:

let std = inputs.nix-std.lib; in
    
with config.scheme;
{
  monitor = [
    ", preferred, auto, auto"
  ];

  env = [
    "XCURSOR_SIZE, 16"
    "HYPRCURSOR_SIZE, 16"
  ];

  general = {
    gaps_in = 20;
    gaps_out = 30;

    "col.active_border" = "rgb(${base07})";
    "col.inactive_border" = base00;

    border_size = 5;
    resize_on_border = true;
    allow_tearing = false;

    layout = "dwindle";
  };

  decoration = {
    rounding = 0;

    active_opacity = 1.0;
    inactive_opacity = 1.0;

    blur = {
      enabled = true;
      size = 5;
      passes = 3;
      ignore_opacity = true;
      vibrancy = 0.16;
    };
  };

  animations = {
    enabled = true;

    bezier = "curve, 0.22, 1, 0.36, 1";

    animation = [
      "windows, 1, 7, curve, slide"
      "workspaces, 1, 6, curve"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  misc = {
    force_default_wallpaper = 0; # Sorry, hypr-chan.
  };

  input = {
    kb_layout = config.machine.locale.layout;

    follow_mouse = 1;
  };

  "$mod" = "WIN";
  "$terminal" = "kitty";
  "$menu" = "nu -c 'tofi-drun | nu -c $in'";

  bind = [
    "$mod, Q, exec, $terminal"
    "$mod, R, exec, $menu"
    "$mod, C, killactive"
    "$mod, M, exit"
    "$mod, F, togglefloating"
    "$mod, E, fullscreen"

    "$mod, mouse_up, workspace, e+1"
    "$mod, mouse_down, workspace, e-1"
  ]
  ++ lib.pipe (std.list.range 0 8) [
    (map
      (n: let ws = toString (n + 1); in
        ''
        $mod, ${ws}, workspace, ${ws}
        $mod SHIFT, ${ws}, movetoworkspace, ${ws}''))
    (map (s: builtins.split "\n" s))
    (lib.flatten)
  ]
  ++ lib.pipe [
    ["up" "u"] ["left" "l"]
    ["down" "d"] ["right" "r"]
  ] [
    (map
      (arr:
        let
          k = builtins.elemAt arr 0;
          d = builtins.elemAt arr 1;
        in ''
      $mod, ${k}, movefocus, ${d}
      $mod SHIFT, ${k}, swapwindow, ${d}''))
    (map (s: builtins.split "\n" s))
    (lib.flatten)
  ];

  bindm = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];

  bindel = [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
  ];
}
