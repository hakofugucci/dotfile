#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfile"

echo "==> Xcode Command Line Tools"
xcode-select -p >/dev/null 2>&1 || xcode-select --install

echo "==> Nix (Determinate)"
if ! command -v nix >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  # 今のシェルでnixを使えるようにする
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

echo "==> Homebrew (GUIアプリ・サービス用)"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> Home Manager"
cd "$DOTFILES"
nix run home-manager/master -- switch --flake .#mac -b backup

echo "==> macOS settings"
[ -f "$DOTFILES/macos.sh" ] && bash "$DOTFILES/macos.sh"

echo "Done."
