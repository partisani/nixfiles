{ inputs, lib, config, ... }:

with lib;

let
    home-cfg = config.machine.home;
    user-cfg = config.machine.user;
in {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    
    options.machine.user = {
        name = mkOption {
            type = types.str;
            default = "who-is-using-the-computer";
        };
        
        description = mkOption {
            type = types.str;
            default = "Who is using this computer";
        };
    };
    
    options.machine.home = mkOption {
        type = types.attrs;
        default = {};
    };
    
    config = {
        users.users."${user-cfg.name}" = {
            description = user-cfg.description;
            isNormalUser = true;
            extraGroups = [ "networkmanager" "wheel" ];
        };

        home-manager.backupFileExtension = "bak";
        home-manager.users."${user-cfg.name}" = _:
            lib.recursiveUpdate
                home-cfg
                {
                    xdg.enable = true;
                    home.stateVersion = "24.11";
                };
    };
}
