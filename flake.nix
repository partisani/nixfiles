{
    description = "My config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixpkgs-pinned.url = "github:NixOS/nixpkgs/05d9eec2b1f158e3cba2c78fef15ac4911955b62";
       
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-colors.url = "github:misterio77/nix-colors";
    };

    outputs = { nixpkgs, nixpkgs-stable, nixpkgs-pinned, home-manager, nix-colors, ... }:
        let
            system = "x86_64-linux";
        in {
        nixosConfigurations.nix-pc = nixpkgs.lib.nixosSystem {
            inherit system; # laziness
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.partisani = import ./home.nix;
                    };
                }
                { home-manager.extraSpecialArgs = { inherit nix-colors; }; }
            ];
            specialArgs = {
                pkgs-stable = import nixpkgs-stable { inherit system; };
                pkgs-pinned = import nixpkgs-pinned { inherit system; };
                inherit nix-colors;
            };
        };
    };
}
