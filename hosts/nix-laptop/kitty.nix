{ config, ... }:

with config.scheme.withHashtag;
{
  # This color configuration was copy & pasted from the internet
  background = base00;
  foreground = base05;
  selection_background = base05;
  selection_foreground = base00;
  url_color = base04;
  cursor = base05;
  cursor_text_color = base00;
  active_border_color = base03;
  inactive_border_color = base01;
  active_tab_background = base00;
  active_tab_foreground = base05;
  inactive_tab_background = base01;
  inactive_tab_foreground = base04;
  tab_bar_background = base01;
  wayland_titlebar_color = base00;
  macos_titlebar_color = base00;

  # normal
  color0 = base00;
  color1 = base08;
  color2 = base0B;
  color3 = base0A;
  color4 = base0D;
  color5 = base0E;
  color6 = base0C;
  color7 = base05;

  # bright
  color8 = base03;
  color9 = base09;
  color10 = base01;
  color11 = base02;
  color12 = base04;
  color13 = base06;
  color14 = base0F;
  color15 = base07;

  # It is my turn now
  font_size = 12;
  modify_font = "cell_height 140%";
  
  window_padding_width = 10;
  cursor_trail = 5;
  cursor_trail_start_threshold = 0;
  cursor_blink_interval = "0.5 ease-in-out";
}
