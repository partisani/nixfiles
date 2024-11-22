{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo
    bacon
    cargo-flamegraph
    rust-analyzer
    mold
  ];
}
