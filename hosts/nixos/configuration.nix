{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # --- Nix ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;   # NVIDIAドライバに必要

  # --- ブート（新SSD内のESPだけを使う）---
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;   # ESPが1GBなので世代を制限
  boot.loader.efi.canTouchEfiVariables = true;

  # --- 基本 ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";   # ttyで日本語が文字化けしないように
  zramSwap.enable = true;

  users.users.hakof = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;

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

  # --- 音 ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # --- 日本語入力 ---
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

  environment.systemPackages = with pkgs; [ git neovim ];

  system.stateVersion = "26.05";   # 初回インストール時の値。以後変えない
}
