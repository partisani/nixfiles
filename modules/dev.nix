{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        ## shell things ##
        kitty
        nushell
        psmisc
        zoxide
        macchina # this is necessary for my current workflow
        pipes-rs
        thefuck # someone when `apt install vim` doesn't have permissions

        ## game dev ##
        godot_4

        ## languages ##
        # js #
        deno
        
        # rust #
        rustup
        rust-script
        mold

        # c(++) #
        gcc
        gnumake
        clang-tools # sorry suckless guys

        # haskell (embrace functionality) #
        ghc
    ];

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };
}
