{ config, lib, pkgs, ... }:
let
  dotfilesDir = "${config.home.homeDirectory}/dotfile";

  # stowパッケージ(common/mac/linux)の「リンク単位」の一覧を返す
  #   .zshrc などの直下のエントリ  -> そのまま
  #   .config の直下の各エントリ    -> ".config/nvim" のように1つずつ
  unitsOf = pkg:
    let
      root      = ../${pkg};
      configDir = root + "/.config";
      top       = builtins.attrNames (builtins.readDir root);
      inConfig  = lib.optionals (builtins.pathExists configDir)
        (map (n: ".config/${n}") (builtins.attrNames (builtins.readDir configDir)));
    in
      (lib.filter (n: n != ".config") top) ++ inConfig;

  # 各単位を、リポジトリ内の実体へのリンクにする
  linkPackage = pkg:
    lib.listToAttrs (map (rel: {
      name  = rel;
      value.source = config.lib.file.mkOutOfStoreSymlink
        "${dotfilesDir}/${pkg}/${rel}";
    }) (unitsOf pkg));
in
{
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  home.file =
    linkPackage "common"
    // linkPackage (if pkgs.stdenv.isDarwin then "mac" else "linux");
}
