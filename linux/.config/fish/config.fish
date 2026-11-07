starship init fish | source
alias vim nvim
alias vi nvim
alias ls 'eza --icons=auto'
alias ll 'eza -l --icons=auto --git'
alias lg lazygit
status is-interactive; and intro quick
# Homebrew llvm (keg-only)。clangd用。Macのみ
if test (uname) = Darwin
    fish_add_path -g /opt/homebrew/opt/llvm/bin
end
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec sway
fi
