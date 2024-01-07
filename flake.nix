{
  description = "My NixOS configuration";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager }@inputs:

    let
      system = "x86_64-linux";

      # overlays = (self: super: {
      #   # steam = super.steam.override {
      #   #   extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${
      #   #       nix-gaming.packages.${system}.proton-ge
      #   #     }'";
      #   # };
      # });

      # specialArgs = {
      #   # pkgs-unstable = import nixpkgs-unstable {
      #   #   inherit system;
      #   #   config.allowUnfree = true;
      #   # };
      #   # pkgs-r2211 = import nixpkgs-r2211 {
      #   #   inherit system;
      #   #   config.allowUnfree = true;
      #   # };
      #   # pkgs-py36 = import nixpkgs-py36 {
      #   #   inherit system;
      #   #   config.allowUnfree = true;
      #   # };
      #   # pkgs-py37 = import nixpkgs-py37 {
      #   #   inherit system;
      #   #   config.allowUnfree = true;
      #   # };
      #   # pkgs-keybase-bumpversion = import nixpkgs-keybase-bumpversion {
      #   #   inherit system;
      #   #   config.allowUnfree = true;
      #   # };
      #   # pkgs-bgremoval = import nixpkgs-bgremoval {
      #   #   inherit system;
      #   #   config.allowUnfree = true;
      #   # };

      #   inherit nixos-hardware system inputs;
      # };

      worker-modules = [
        ./users/worker/user.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            users.worker = import ./users/worker/hm.nix;
            # extraSpecialArgs = specialArgs;
          };
        }
        # ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
      ];

    in
    {
      nixosConfigurations = {

        qemunix = nixpkgs.lib.nixosSystem {
          # inherit system specialArgs;
          modules = worker-modules ++ [ ./hosts/qemunix.nix ];
        };

        thinknix460p = nixpkgs.lib.nixosSystem {
          # inherit system specialArgs;
          modules = worker-modules ++ [ ./hosts/thinknix460p.nix ];
        };
      };
    };
}
  