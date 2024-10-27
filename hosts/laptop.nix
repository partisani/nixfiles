{ config, pkgs, ... }:

{
    imports = nixModules;
    
    # Declared by importing nixModules
    modules = {
        networking = {
            enable = true;
            hostname = "laptop"
        };
    };
}
