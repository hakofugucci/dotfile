{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
        mac  = mkHome "aarch64-darwin" [
        ./home/dotfile.nix 
        ./home/packages.nix 
        ./home/darwin.nix 
        ];
        arch = mkHome "x86_64-linux"   [
        ./home/dotfile.nix 
        ./home/packages.nix 
        ./home/linux.nix 
        ];
      };
    };
}
