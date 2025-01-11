{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs; [ gcc clang-tools ];
}
