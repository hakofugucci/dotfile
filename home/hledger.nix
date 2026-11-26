# home/hledger.nix など
{ pkgs, ... }:
let
  hledger-lsp = pkgs.callPackage ../pkgs/hledger-lsp.nix { };
in
{
  home.packages = [
    pkgs.hledger
    pkgs.hledger-ui
    pkgs.hledger-web
    pkgs.hledger-fmt
    hledger-lsp
  ];
}
