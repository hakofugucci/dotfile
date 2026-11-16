# mac/.zprofile
# Docker Desktop が追記するセクション（Docker 側が書き換えるので残す）
export PATH="$PATH:/Users/hakofugucci/.docker/bin"
# End of Docker Desktop section.

# Homebrew（Apple Silicon 固定）。PATH は末尾に足して Nix を優先する
export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_CELLAR=/opt/homebrew/Cellar
export HOMEBREW_REPOSITORY=/opt/homebrew
typeset -U path
path+=(/opt/homebrew/bin /opt/homebrew/sbin)
