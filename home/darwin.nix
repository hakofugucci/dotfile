{ pkgs, ... }:
{
  home.username = "hakof";
  home.homeDirectory = "/Users/hakof";

  home.packages = with pkgs; [
    macism
  ];
}
