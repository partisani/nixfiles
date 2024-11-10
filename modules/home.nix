{ username, description ? username }:

{ inputs, lib, config, ... }:

with lib;

let cfg = config.machine.home; in {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    
    options.machine.home = mkOption {
        type = types.attrs;
        default = {};
    };
    
    config = {
        users.users."${username}" = {
            inherit description;
            isNormalUser = true;
            extraGroups = [ "networkmanager" "wheel" ];
        };
        
        home-manager.users."${username}" = _:
            lib.recursiveUpdate
                cfg
                {
                    xdg.enable = true;
                    home.stateVersion = "24.11";
                };
    };
}
