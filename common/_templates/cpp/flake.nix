{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAll = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in {
      devShells = forAll (pkgs: {
        default = pkgs.mkShell.override { stdenv = pkgs.llvmPackages.libcxxStdenv; } {
          packages = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.llvmPackages.lld ];
          LIBCXX_LIB = "${pkgs.llvmPackages.libcxx}/lib";
        };
        
      });
    };
}
