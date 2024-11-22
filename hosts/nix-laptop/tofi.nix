{ config, ... }:

with config.scheme.withHashtag;
{
  text-cursor = true;
  terminal = "kitty";

  # STYLE

  font = "monospace black";

  prompt-text = " > ";

  background-color = "${base00}77";
  text-color = base04;
  prompt-color = base07;
  selection-color = base07;
}
