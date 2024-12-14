{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo
    bacon
    cargo-flamegraph
    rust-analyzer
    mold
    clang
  ];

  machine.home.home.file.".cargo/config.toml".text = ''
  [target.x86_64-unknown-linux-gnu] 
  linker = "clang" 
  rustflags = ["-C", "link-arg=--ld-path=mold"]
  '';
}
