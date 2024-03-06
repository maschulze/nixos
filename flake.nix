#
#  flake.nix *
#   ├─ ./base
#   │   └─ default.nix
#   ├─ ./disko
#   │   └─ simple-bios.nix
#   │   └─ simple-efi.nix
#   ├─ ./home
#   │   └─ default.nix
#   ├─ ./hosts
#   │   └─ qemu.nix
#   │   └─ thinkpad.nix
#   ├─ ./modules
#   │   └─ default.nix
#   ├─ ./overlays
#   │   └─ default.nix
#   └─ ./services
#       └─ default.nix
#

{

  description = "My Nix and NixOS System Flake Configuration";

  inputs = {

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-23.11";
    };

    # nixpkgs-unstable-small = {
    #   type = "github";
    #   owner = "NixOS";
    #   repo = "nixpkgs";
    #   ref = "nixos-unstable-small";
    # };

    # agenix = {
    #   type = "github";
    #   owner = "ryantm";
    #   repo = "agenix";
    # };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake-utils = {
    #   type = "github";
    #   owner = "numtide";
    #   repo = "flake-utils";
    #   ref = "master";
    # };

    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      ref = "master";
    };

    disko = {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      ref = "master";
    };
  };



  outputs = { self, nixpkgs, home-manager, nixos-hardware, disko, ... } @ inputs:

    let

      my_overlay = (self: super: {
        # steam = super.steam.override {
        #   extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${
        #       nix-gaming.packages.${system}.proton-ge
        #     }'";
        # };
        # # prevent openssh from checking perms of ~/.ssh/config to appease vscode
        # # https://github.com/nix-community/home-manager/issues/322
        # openssh = super.openssh.overrideAttrs (old: {
        #   patches = (old.patches or [ ]) ++ [
        #     ./patches/openssh-dontcheckconfigperms.patch
        #   ];
        #   doCheck = false;
        # });
      });

      overlays = [ my_overlay ];

      system = "x86_64-linux";

      specialArgs = {
        # pkgs-unstable = import nixpkgs-unstable {
        #   inherit system;
        #   config.allowUnfree = true;
        # };
        # pkgs-olive = import nixpkgs-olive {
        #   inherit system;
        #   config.allowUnfree = true;
        # };
        # pkgs-py36 = import nixpkgs-py36 {
        #   inherit system;
        #   config.allowUnfree = true;
        # };
        # pkgs-py37 = import nixpkgs-py37 {
        #   inherit system;
        #   config.allowUnfree = true;
        # };
        # pkgs-py39 = import nixpkgs-py39 {
        #   inherit system;
        #   config.allowUnfree = true;
        # };
        # pkgs-keybase-bumpversion = import nixpkgs-keybase-bumpversion {
        #   inherit system;
        #   config.allowUnfree = true;
        # };
        # bigger-darwin = nixtheplanet.legacyPackages.x86_64-linux.makeDarwinImage {
        #   diskSizeBytes = 100000000000;
        # };
        # nixgl-olive = nixgl-olive.defaultPackage.x86_64-linux.nixGLIntel;

        inherit nixos-hardware system inputs;
      };

      worker-modules = [
        ./users/worker/user.nix
        home-manager.nixosModules.default
        disko.nixosModules.default
        # nixtheplanet.nixosModules.macos-ventura
        {
          home-manager = {
            useUserPackages = true;
            users.worker = import ./users/worker/home.nix;
            extraSpecialArgs = specialArgs;
          };
        }
        ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
      ];

    in
    {

      nixosConfigurations = {
        hypernix = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = worker-modules ++ [ ./hosts/hypernix.nix ];
        };
        qemunix = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = worker-modules ++ [ ./hosts/qemunix ];
        };
      };

  #     vars = {
  #       user = "worker";
  #     };

  #     nixosModules = {

  #       home = {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.useUserPackages = true;
  #         home-manager.users.${self.vars.user} = import ./home;
  #         home-manager.verbose = true;
  #       };

  #       # nix-path = {
  #       #   nix = {
  #       #     nixPath = [
  #       #       "nixpkgs=${inputs.nixpkgs}"
  #       #     ];
  #       #     registry = {
  #       #       nixpkgs.flake = inputs.nixpkgs;
  #       #     };
  #       #   };
  #       # };
  #     };

  #     overlays = import ./overlays;

  #     nixosConfigurations =
  #       let
  #         system = "x86_64-linux";
  #         shared_overlays =
  #           [
  #             (self: super: {
  #               packages = import ./pkgs { pkgs = super; };

  #               # packages accessible through pkgs.unstable.package
  #               # unstable = import inputs.nixpkgs-unstable-small {
  #               #   inherit system;
  #               #   config.allowUnfree = true;
  #               # };
  #             })

  #             # agenix.overlays.default
  #           ]
  #           ++ builtins.attrValues self.overlays;

  #         sharedModules =
  #           [
  #             # agenix.nixosModules.default
  #             home-manager.nixosModules.default
  #             {
  #               nixpkgs = {
  #                 overlays = shared_overlays;
  #                 config.permittedInsecurePackages = [ ];
  #               };
  #               hardware.enableRedistributableFirmware = true;
  #             }
  #           ]
  #           ++ (nixpkgs.lib.attrValues self.nixosModules);

  #       in
  #       {

  #         qemu = nixpkgs.lib.nixosSystem {
  #           inherit system;
  #           modules =
  #             [
  #               disko.nixosModules.default
  #               ./hosts/qemu.nix
  #             ]
  #             ++ sharedModules;
  #         };

  #         thinkpad = nixpkgs.lib.nixosSystem {
  #           inherit system;
  #           modules =
  #             [
  #               disko.nixosModules.default
  #               ./hosts/thinkpad.nix
  #             ]
  #             ++ sharedModules;
  #         };

  #         # hades = nixpkgs.lib.nixosSystem rec {
  #         #   inherit system;
  #         #   modules =
  #         #     [
  #         #       ./hades.nix
  #         #     ]
  #         #     ++ sharedModules;
  #         # };

  #         # boreal = nixpkgs.lib.nixosSystem rec {
  #         #   inherit system;
  #         #   modules =
  #         #     [
  #         #       ./boreal.nix

  #         #       {
  #         #         nixpkgs.overlays = [
  #         #           # uncomment this to build everything from scratch, fun but takes a
  #         #           # while
  #         #           #
  #         #           # (self: super: {
  #         #           #   stdenv = super.impureUseNativeOptimizations super.stdenv;
  #         #           # })
  #         #         ];
  #         #       }
  #         #     ]
  #         #     ++ sharedModules;
  #         # };

  #         # hephaestus = nixpkgs.lib.nixosSystem rec {
  #         #   inherit system;
  #         #   modules =
  #         #     [
  #         #       ./hephaestus.nix

  #         #       inputs.nixos-hardware.nixosModules.common-cpu-amd
  #         #       inputs.nixos-hardware.nixosModules.common-gpu-amd
  #         #       inputs.nixos-hardware.nixosModules.common-pc-laptop
  #         #       inputs.nixos-hardware.nixosModules.common-pc-ssd
  #         #     ]
  #         #     ++ sharedModules;
  #         # };

  #         # thanatos = nixpkgs.lib.nixosSystem {
  #         #   inherit system;
  #         #   modules =
  #         #     [
  #         #       disko.nixosModules.default
  #         #       ./thanatos.nix
  #         #     ]
  #         #     ++ sharedModules;
  #         # };
        # };
    };
  # # inputs.flake-utils.lib.eachDefaultSystem (system: {
  # #   packages =
  # #     inputs.flake-utils.lib.flattenTree
  # #     (import ./pkgs {
  # #       pkgs = import nixpkgs {inherit system;};
  # #     });
  # # });
}
