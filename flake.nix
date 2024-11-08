{
    description = "Modular system flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        nixosConfigurations.nix-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/nix-laptop.nix ];
        };
    };  
}
