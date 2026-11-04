#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "==> Xcode Command Line Tools"
xcode-select -p >/dev/null 2>&1 || xcode-select --install

echo "==> Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> stow"
cd "$DOTFILES"
stow -t "$HOME" common mac

echo "==> macOS settings"
[ -f "$DOTFILES/macos.sh" ] && bash "$DOTFILES/macos.sh"

echo "Done."
