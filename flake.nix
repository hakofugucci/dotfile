{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          inherit modules;
        };
    in {
      homeConfigurations = {
        mac = mkHome "aarch64-darwin" [
          ./home/dotfile.nix
          ./home/packages.nix
          ./home/darwin.nix
        ];
        arch = mkHome "x86_64-linux" [
          ./home/dotfile.nix
          ./home/packages.nix
          ./home/linux.nix
        ];
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hakof = {
              imports = [
                ./home/dotfile.nix
                ./home/packages.nix
                ./home/linux.nix
                ./home/nixos.nix
              ];
            };
          }
        ];
      };
    };
}
