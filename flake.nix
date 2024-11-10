{
    description = "Modular system flake.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        
        utils.url = "path:utils";
        
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, utils, ... }@inputs: {
        nixosConfigurations = utils.lib.makeHosts
            ./hosts
            (utils.lib.makeHostInputs {
                inherit inputs;
                modulesPath = ./modules;
            });
    };  
}
