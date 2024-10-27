{
    description = "Pure nix library that aims to allow for a better experience with organizing a system flake.";
    
    outputs = { ... }: {
        lib = {
            createHosts = { self, path, args }:
            let
                inherit (builtins) map readDir;
                inherit (lib.lists) 
            in map () (readDir path);
        };
    };
}
