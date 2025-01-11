{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs; [ lua5_4_compat ];
}
