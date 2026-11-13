{ pkgs, ... }:
{
  home.username = "hakofugucci";
  home.homeDirectory = "/Users/hakofugucci";

  home.packages = with pkgs; [
    jankyborders
    macism
    sketchybar
  ];
}
