{
  description = "Modular system flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-crit.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    utils.url = "path:utils";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    base16.url = "github:SenchoPens/base16.nix";

    nix-std.url = "github:chessai/nix-std";
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
