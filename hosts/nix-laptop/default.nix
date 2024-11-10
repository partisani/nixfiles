# Thinkpad T440p running NixOS Vicuna (24.11)
# Specs:
#   - Intel Core i7-4600M (4) @ 3.60GHz
#   - Intel HD Graphics 4600
#   - 16GB of RAM
#   - 256GB Main SSD + 128GB External SSD
inputs:

{
    system = "x86_64-linux";
    modules = [ ./config.nix ./hardware.nix ];
    specialArgs = { inherit inputs; };
}
