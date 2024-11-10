{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };
    
    outputs = { nixpkgs, ... }: {
        lib =
        let
            lib = nixpkgs.lib;
            inherit (lib) removeSuffix mapAttrs mapAttrs' nameValuePair nixosSystem;
            inherit (builtins) readDir replaceStrings;
        in rec {
            removeNixSuffix = removeSuffix ".nix";
            
            # Returns an attrset where the key is the host's name
            # and the value is the path to the host's directory.
            getHostPaths = path: (
                mapAttrs
                    (key: _: path + ("/" + key))
                    (readDir path)
            );
            
            # Takes an attrset where the key is the host's name
            # and the value is the path to the host's directory,
            # and generates an attrset of nixos configurations
            makeHostConfigurations = inputs: hostAttrs: (
                mapAttrs
                    (_: val: nixosSystem (import val inputs))
                    (hostAttrs)
            );
            
            # Takes in your flake's inputs and a path to the
            # modules directory, and returns a modified inputs
            # attrset, that will be passed to your hosts
            makeHostInputs = { inputs, modulesPath }: (
                inputs // {
                    modules = mapAttrs'
                        (key: val:
                            nameValuePair
                                # Key
                                (replaceStrings ["."] ["-"] (removeNixSuffix key))
                                # Value
                                (modulesPath + ("/" + (removeNixSuffix key) +
                                    (if val == "directory" then "/default.nix" else ".nix"))))
                        (readDir modulesPath);
                }
            );
            
            makeHosts = path: inputs: (
                makeHostConfigurations inputs (getHostPaths path)
            );
        };
    };
}
