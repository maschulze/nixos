{ config, lib, pkgs, ... }:

let

  inherit (lib) mkEnableOption mkIf;

  cfg = config.my.home.htop;

in
{
  options.my.home.htop.enable = mkEnableOption "Htop configuration";

  config = mkIf cfg.enable {

    programs.htop = {

      enable = true;
    };
  };
}
