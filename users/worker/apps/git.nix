{ config, lib, pkgs, ... }:

with lib;
let

  cfg = config.apps.system.git;

in
{

  options = { };

  config = mkIf cfg.enable {

    programs.git = {

      enable = true;

      # delta = {
      #   enable = true;
      #   options = {
      #     syntax-theme = "Solarized (light)";
      #   };
      # };
      # lfs.enable = true;

      userName = "maschulze";
      userEmail = "7000347+maschulze@users.noreply.github.com";

      # extraConfig = {
      #   commit = { verbose = true; };
      #   core = { editor = "vim"; };
      #   init = { defaultBranch = "main"; };
      #   pull = { rebase = true; };
      #   rerere = { enabled = true; };
      #   maintenance.prefetch.enabled = false;
      # };

      # aliases = {
      #   push-wip = "push -o ci.skip";
      #   push-merge = "push -o merge_request.create -o merge_request.merge_when_pipeline_succeeds -o merge_request.remove_source_branch";
      #   push-mr = "push -o merge_request.create -o merge_request.remove_source_branch";
      # };

      # includes = [
      #   {
      #     condition = "gitdir:~/work/lrde/";
      #     contents = { user = { email = "amartin@lrde.epita.fr"; }; };
      #   }
      #   {
      #     condition = "gitdir:~/work/prologin/";
      #     contents = { user = { email = "antoine.martin@prologin.org"; }; };
      #   }
      #   {
      #     condition = "gitdir:~/work/epita/";
      #     contents = { user = { email = "antoine4.martin@epita.fr"; }; };
      #   }
      # ];

      # ignores = [
      #   "/.direnv/"
      #   "/.envrc"
      # ];
    };
  };
}
