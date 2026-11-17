{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    fuzzel
    ghostty
    grim
    playerctl
    pulseaudio      # pactl 用。音声サーバーは pipewire
    slurp
    waybar
    wl-clipboard
    bitwarden-desktop # password manager
    anki
  ];
}
