{ lib, config, ... }:

with lib;

let cfg = config.machine.locale; in {
    options.machine.locale = {
        language = mkOption {
            type = types.str;
            default = "en_US.UTF-8";
        };
        
        timeZone = mkOption {
            type = types.str;
            # It is my fault for not knowing what other timezone to put in here
            default = "America/Bahia";
        };
        
        alternateLanguage = mkOption {
            type = types.str;
            default = cfg.language;
        };
        
        layout = mkOption {
            type = types.str;
            default = "en";
        };
    };
    
    config = {
        time.timeZone = cfg.timeZone;

        i18n.defaultLocale = cfg.language;

        i18n.extraLocaleSettings = {
            LC_ADDRESS = cfg.alternateLanguage;
            LC_IDENTIFICATION = cfg.alternateLanguage;
            LC_MEASUREMENT = cfg.alternateLanguage;
            LC_MONETARY = cfg.alternateLanguage;
            LC_NAME = cfg.alternateLanguage;
            LC_NUMERIC = cfg.alternateLanguage;
            LC_PAPER = cfg.alternateLanguage;
            LC_TELEPHONE = cfg.alternateLanguage;
            LC_TIME = cfg.alternateLanguage;
        };

        services.xserver.xkb.layout = cfg.layout;
        console.useXkbConfig = true;
    };
}