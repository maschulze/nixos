{ config, pkgs, ... }:

let

in
{
  imports = [ ../keybase.nix ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # xdotool
    # fd # fd is an unnamed dependency of fzf
    # shell-genie
    # nushell
    # oh-my-posh # not enabled via programs.xxx cuz dont want it enabled in zsh
  ];
  home.stateVersion = "22.11";
}
