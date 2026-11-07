starship init fish | source
alias vim nvim
alias vi nvim
alias ls 'eza --icons=auto'
alias ll 'eza -l --icons=auto --git'
alias lg lazygit
status is-interactive; and intro quick
# Homebrew llvm (keg-only)。clangd用。Macのみ
if status is-login

    if test (uname) = Darwin
        fish_add_path -g /opt/homebrew/opt/llvm/bin
    end

    if test -z "$WAYLAND_DISPLAY"  and [ "$XDG_VTNR" = 1 ];
        exec sway
    end

end
