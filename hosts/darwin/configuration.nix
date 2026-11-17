{ pkgs, ... }:
{
  # Determinate Nix が Nix 本体を管理するので無効化
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "hakof";
  system.stateVersion = 6;

  users.users.hakof.home = "/Users/hakof";

  # zsh を使っているなら、シェル周りの統合を有効にする
  programs.zsh.enable = true;
}
