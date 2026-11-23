{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # --- Nix ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;   # NVIDIA driver

  # --- boot ---
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    configurationLimit = 10;
  };
  # --- base ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";
  zramSwap.enable = true;

  users.users.hakof = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;

  # --- auto cleanup ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;
  # --- NVIDIA（RTX 4060）---
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- sway ---
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  # --- niri / Hyprland ---
  programs.niri.enable = true;
  programs.hyprland.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  # --- sound ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # --- japanese ---
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
    udev-gothic-nf
  ];

  environment.systemPackages = with pkgs; [ git neovim  pkgs.sbctl ];

  system.stateVersion = "26.05";}
