{ pkgs, ... }:
{
  # Determinate Nix が Nix 本体を管理するので無効化
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "hakof";
  system.stateVersion = 6;

  users.users.hakof.home = "/Users/hakof";

  environment.systemPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];

  # zsh を使っているなら、シェル周りの統合を有効にする
  programs.zsh.enable = true;

  networking.hostName = "hakof";       # HostName
  networking.localHostName = "hakof";  # LocalHostName (hakof.local)
  networking.computerName = "hakof";   # 「システム設定」に表示される名前
  # hosts/darwin/configuration.nix
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";   # 後で "check" → "uninstall" に強める
    };

    taps = [
      "asmvik/formulae"
      "felixkratz/formulae"
    ];

    brews = [
      "yabai"
      "skhd"
      "sketchybar"
      "borders"
    ];

    casks = [
      "adobe-creative-cloud"
      "alfred"
      "anki"
      "appcleaner"
      "bitwarden"
      "blender"
      "cloudflare-warp"
      "font-sf-pro"
      "font-sketchybar-app-font"
      "ghostty"
      "linearmouse"
      "obsidian"
      "sf-symbols"
      "slack"
      "steam"
      "wacom-tablet"
      "zoom"
      "zotero"
    ];
  };
}

