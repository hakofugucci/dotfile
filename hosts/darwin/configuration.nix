{ pkgs, ... }:
{
  # Disable because use Determinate Nix
  nix.enable = false;
  # mac system default
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
    dock.autohide = true;
  };
  nixpkgs.hostPlatform = "aarch64-darwin";
  # INFO: Overwrite your username instead of "hakof"
  networking.hostName = "hakof";       # HostName
  networking.localHostName = "hakof";  # LocalHostName (hakof.local)
  networking.computerName = "hakof";   # visual name

  system.primaryUser = "hakof";
  system.stateVersion = 6;

  users.users.hakof.home = "/Users/hakof";

  environment.systemPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];

  services.tailscale.enable = true;

  launchd.user.agents.syncthing = {
    serviceConfig = {
      ProgramArguments = [ "${pkgs.syncthing}/bin/syncthing" "--no-browser" ];
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/tmp/syncthing.log";
      StandardErrorPath = "/tmp/syncthing.err";
    };
  };

  environment.systemPackages = [ pkgs.syncthing ];

  # zsh integration
  programs.zsh.enable = true;

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall"; # INFO: package doesn't declarate will uninstall
    };

    taps = [
      "asmvik/formulae"
      "felixkratz/formulae"
    ];

    brews = [
      { name = "asmvik/formulae/yabai";        trusted = true; }
      { name = "asmvik/formulae/skhd";         trusted = true; }
      { name = "felixkratz/formulae/sketchybar"; trusted = true; }
      { name = "felixkratz/formulae/borders";  trusted = true; }
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
      "discord"
    ];

    masApps = {}; 
  };
}

