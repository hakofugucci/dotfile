{ pkgs, config, ... }:
{
  # ~/.config/rice を、flake 外の編集可能な実体に向ける
  xdg.configFile."rice".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfile/rice";   # ← 実際のリポジトリの場所に合わせる

  home.packages = [
    pkgs.gum
    pkgs.fuzzel
    (pkgs.writeShellApplication {
      name = "desk";
      runtimeInputs = [ pkgs.gum ];
      text = ''
        profile="''${1:-$(gum choose minimal-sway niri hypr)}"
        export RICE_PROFILE="$profile"
        cfg="$HOME/.config/rice/$profile"

        case "$profile" in
          minimal-sway) exec sway -c "$cfg/sway/config" ;;
          niri)         exec niri --config "$cfg/niri/config.kdl" ;;
          hypr)         exec Hyprland -c "$cfg/hypr/hyprland.conf" ;;
          *) echo "unknown profile: $profile" >&2; exit 1 ;;
        esac
      '';
    })
  ];
}
