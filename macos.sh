#!/usr/bin/env bash
set -euo pipefail

# Finder: 拡張子を常に表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# キーリピートを速く(値が小さいほど速い)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Dock: 自動で隠す
defaults write com.apple.dock autohide -bool true

killall Finder Dock >/dev/null 2>&1 || true
