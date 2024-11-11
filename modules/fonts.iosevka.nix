{
    config,
    pkgs,
    ...
}:

let
    iosevka-homemade =
        (pkgs.iosevka.override {
            set = "Homemade";
            privateBuildPlan = builtins.readFile resources/iosevka.toml;
        });
    iosevka-homemade-nerd = let outDir = "$out/share/fonts/truetype/"; in
        # Shamelessly stolen from @muni-corn on github and his
        # repository: https://codeberg.org/harrisonthorne/iosevka-muse/src/branch/main/flake.nix#L24
        pkgs.stdenv.mkDerivation {
            pname = "iosevka-homemade-nerd";
            version = iosevka-homemade.version;

            src = iosevka-homemade.src;

            buildInputs = [ pkgs.nerd-font-patcher ];

            configurePhase = "mkdir -p ${outDir}";
            buildPhase = ''
              for fontfile in ${iosevka-homemade}/share/fonts/truetype/*
              do
              nerd-font-patcher $fontfile --complete --careful --outputdir ${outDir}
              done
            '';
        };
in {
    # Fonts
    fonts.fontDir.enable = true;
    
    fonts.packages = with pkgs; [
        iosevka-homemade
        iosevka-homemade-nerd
        (iosevka-bin.override { variant = "Aile"; })
    ];
}
