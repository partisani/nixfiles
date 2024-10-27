{
    description = "Modular system flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        flake-tree.url = "path:lib/flake-tree";
    };

    outputs = { self, nixpkgs, home-manager, flake-tree, ... }: {
        #nixosConfigurations = flake-tree.lib.createHosts {
        #    inherit self;
        #    path = ./hosts;
        #    
        #    args = {
        #        home-manager = import home-manager.nixosModules.default;
        #    };
        #};
        nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        };
    };  
}
