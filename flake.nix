{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, lanzaboote, ... }:
    let
      mkHome = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          inherit modules;
        };
    in {
      # 移行が終わるまで残しておく(終わったら削除してよい)
      homeConfigurations = {
        mac = mkHome "aarch64-darwin" [
          ./home/dotfile.nix
          ./home/packages.nix
          ./home/darwin.nix
        ];
      };

      darwinConfigurations."hakof" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.backupFileExtension = "backup";
            home-manager.users.hakof = {
              imports = [
                ./home/dotfile.nix
                ./home/packages.nix
                ./home/darwin.nix
              ];
            };
          }
        ];
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          lanzaboote.nixosModules.lanzaboote
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.hakof = {
              imports = [
                ./home/dotfile.nix
                ./home/packages.nix
                ./home/linux.nix
                ./home/nixos.nix
                ./home/rice.nix
              ];
            };
          }
        ];
      };
    };
}
