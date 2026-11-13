# dotfile
## 前提
- 全マシンで ~/dotfile に置く（home/dotfile.nix がこのパスを参照する）
## mac
1. git clone → bash ~/dotfile/mac-bootstrap.sh
2. 更新: home-manager switch --flake .#mac
## 手動で必要なもの
- GitHubのアクセストークン（~/.config/nix/nix.conf の access-tokens）
- アクセシビリティ権限（skhd, yabai など）
