# 仮置き。インストール時に nixos-generate-config の出力で置き換える
{ lib, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  fileSystems."/" = { device = "/dev/disk/by-label/NIXOS_ROOT"; fsType = "ext4"; };
  fileSystems."/boot" = { device = "/dev/disk/by-label/NIXOS_BOOT"; fsType = "vfat"; };
}
