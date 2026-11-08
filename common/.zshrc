# Created by newuser for 5.9.2
# キーバインド指定
zmodload zsh/terminfo
bindkey -e
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

[[ -n "${key[Up]}" ]] && bindkey -- ${key[Up]} history-beginning-search-backward
[[ -n "${key[Down]}" ]] && bindkey -- ${key[Down]}  history-beginning-search-forward
# アプリケーション状態を指定
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
# エイリアス
alias vim=nvim
alias vi=nvim
alias ls='eza --icons=auto'
alias la='eza -a --icons=auto'
alias ll='eza -|--icons=auto --git'
alias lg=lazygit
alias g=git
alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
source <(fzf --zsh)
eval "$(zoxide init zsh)"
# プラグイン設定
source ~/src/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(~/src/zsh-completions/src $fpath)
source ~/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# 履歴保存
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=10000
# 履歴をセッションを跨いで保存
setopt SHARE_HISTORY
# 重複削除
setopt HIST_IGNORE_ALL_DUPS
# 先頭スペース付きのコマンドを記録しない
setopt HIST_IGNORE_SPACE
# 補完
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
# starship
eval "$(starship init zsh)"

