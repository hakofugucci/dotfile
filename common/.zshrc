# Created by newuser for 5.9.2
if [[ -n $ZSH_PROF ]]; then
  zmodload zsh/zprof zsh/datetime
  _t0=$EPOCHREALTIME
  _lap() { printf '%7.1f ms  %s\n' $(( (EPOCHREALTIME - _t0) * 1000 )) "$1" >&2; _t0=$EPOCHREALTIME }
else
  _lap() { :; }
fi
# ---------- キーバインド ---------- 
zmodload zsh/terminfo
bindkey -e
typeset -g -A key
# history-searchを行末から開始
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end




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

[[ -n "${key[Home]}" ]]      && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}" ]]       && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}" ]]    && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}" ]]    && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Left]}" ]]      && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}" ]]     && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
[[ -n "${key[Up]}" ]]        && bindkey -- "${key[Up]}"        history-beginning-search-backward-end
[[ -n "${key[Down]}" ]]      && bindkey -- "${key[Down]}"      history-beginning-search-forward-end
# 単語移動
bindkey '^[[1;5C' forward-word   # Ctrl+→ (Linux)
bindkey '^[[1;5D' backward-word  # Ctrl+←
bindkey '^[[1;3C' forward-word   # Option/Alt+→ (Mac)
bindkey '^[[1;3D' backward-word  # Option/Alt+←
bindkey '^[b' backward-word      # Option+←がESC bで来る端末向け
bindkey '^[f' forward-word
# アプリケーション状態を指定
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

_lap keybinds

# ---------- オプション ----------
setopt AUTO_CD              # ディレクトリ名だけでcd
setopt INTERACTIVE_COMMENTS # 対話シェルで # コメントを許可
setopt auto_pushd

# ---------- 履歴 ----------


HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

_lap history

# ---------- 補完 ----------
fpath=(~/.nix-profile/share/zsh/site-functions $fpath)

autoload -Uz compinit
() {
  setopt local_options extended_glob
  local dump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump
  mkdir -p ${dump:h}
  if [[ ! -f $dump || -n $dump(#qN.mh+24) ]]; then
    compinit -d $dump
  else
    compinit -C -d $dump
  fi
}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

_lap compinit

# ---------- エイリアス ----------
export EDITOR=nvim
export VISUAL=nvim
alias vim=nvim
alias vi=nvim
alias v=nvim

# 拡張子だけ打つと nvim で開く（suffix alias）
alias -s {txt,md,json,toml,yaml,yml,lua,c,cpp,h,hpp,cmake,sh,zsh,py,rs,go,js,ts,html,css}=nvim
alias ls='eza --icons=auto'
alias la='eza -a --icons=auto'
alias ll='eza -l --icons=auto --git'
alias lg=lazygit
alias g=git
alias ga='git add'
alias gaa='git add -A'
alias gac='git add -A && git commit -m'
alias gc='git commit -m'
alias gcn='git commit --allow-empty-message -m ""'
alias gacn='git add -A && git commit --allow-empty-message -m ""'
alias gp='git push'
alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gsu='git stash -u'
alias gsp='git stash pop'
alias fuck='f'

# cpp c23 build
if [[ "$(uname)" == "Darwin" ]]; then
  export MACOSX_DEPLOYMENT_TARGET=27.2
  LLVM=/opt/homebrew/opt/llvm
  alias c23="$LLVM/bin/clang++ -std=c++23 -stdlib=libc++ -L$LLVM/lib/c++ -Wl,-rpath,$LLVM/lib/c++ -Wall -Wextra"
else
  alias c23='clang++ -std=c++23 -stdlib=libc++ -fuse-ld=lld -Wall -Wextra'
fi

# ---------- PATH ----------
typeset -U path   # 重複を自動で除く
path=($HOME/.local/bin $path)

# ---------- ツール ----------
# fzfの配色(tokyonight-night)
export FZF_DEFAULT_OPTS="
  --height=40%
  --highlight-line
  --info=inline-right
  --ansi
  --layout=reverse
  --border=none
  --color=bg+:#283457
  --color=bg:#16161e
  --color=border:#27a1b9
  --color=fg:#c0caf5
  --color=gutter:#16161e
  --color=header:#ff9e64
  --color=hl+:#2ac3de
  --color=hl:#2ac3de
  --color=info:#545c7e
  --color=marker:#ff007c
  --color=pointer:#ff007c
  --color=prompt:#2ac3de
  --color=query:#c0caf5:regular
  --color=scrollbar:#27a1b9
  --color=separator:#ff9e64
  --color=spinner:#ff007c
"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

_cache_eval() {                       # 使い方: _cache_eval 名前 コマンド 引数...
  local name=$1; shift
  local real=${${commands[$1]}:A}     # コマンドの実体パス（シンボリックリンクを解決）
  [[ -n $real ]] || return 0          # コマンドが無ければ何もしない
  local key="# $real $*"
  local f=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/$name.zsh first=
  [[ -r $f ]] && IFS= read -r first < $f
  if [[ $first != $key ]]; then       # 初回か、パス・引数が変わったときだけ再生成
    local out
    out=$("$@") || return 0           # 失敗したらキャッシュしない
    mkdir -p ${f:h}
    print -r -- "$key"$'\n'"$out" >| $f
  fi
  source $f
}

_cache_eval fzf fzf --zsh
_lap fzf
_cache_eval zoxide zoxide init zsh
_lap zoxide
_cache_eval starship starship init zsh --print-full-init
_lap starship
_cache_eval direnv direnv hook zsh
_lap direnv
_cache_eval pay-respects pay-respects zsh --alias
_lap pay-respects
export CARAPACE_BRIDGES='zsh,fish,bash'
_cache_eval carapace carapace _carapace
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
_lap carapace

source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
_lap autosuggestions


# ------------ 関数 ------------
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
export DOTFILES="$HOME/dotfile"

# newcpp <名前>: テンプレートからC++プロジェクトを作ってビルドする
function newcpp() {
    if (( $# != 1 )); then
        echo "usage: newcpp NAME"
        return 1
    fi

    local proj="$1"
    if [[ ! $proj =~ '^[A-Za-z0-9_-]+$' ]]; then
        echo "invalid name: use letters, digits, _ and -"
        return 1
    fi

    local tpl="$DOTFILES/common/_templates/cpp"
    local dest="$HOME/dev/cpp/$proj"

    [[ -d $tpl ]]  || { echo "template not found: $tpl"; return 1 }
    [[ -e $dest ]] && { echo "already exists: $dest"; return 1 }

    cp -R "$tpl" "$dest" || return 1
    direnv allow "$dest" >/dev/null
    builtin cd -- "$dest" || return 1

    # @NAME@ を置換(sedを使わないのでMacとArchで差が出ない)
    local content="$(<CMakeLists.txt)"
    print -r -- "${content//@NAME@/$proj}" > CMakeLists.txt || return 1

    git init -q
    git add .
    nix flake lock || return 1
    git add flake.lock
    git commit -qm "initial commit"
    # flakeの開発環境の中でビルドする(direnvに依存しない)
    nix develop -c cmake --preset debug \
        && nix develop -c cmake --build --preset debug \
        && echo "ok: ./build/debug/$proj"
}

# yazi: 終了時にyaziで開いていたディレクトリへcdする
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [[ -n $cwd && $cwd != $PWD && -d $cwd ]] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# intro: ターミナルのオープニング演出
function intro() {
    local name="${1:-banner}"
    local effects=(decrypt beams slide wipe rain)
    local picks=(matrix pipes bonsai aquarium lava genact train fortune)

    case $name in
        banner)
            clear
            figlet "$(whoami)" | lolcat
            echo
            fastfetch --pipe false | tte ${effects[RANDOM % ${#effects} + 1]}
            ;;
        quick)
            figlet "$(whoami)" | lolcat
            fastfetch
            ;;
        matrix)   cmatrix -C blue -b ;;
        aquarium) asciiquarium ;;
        genact)   genact ;;
        train)    sl ;;
        random)   intro ${picks[RANDOM % ${#picks} + 1]} ;;
        list)     echo "banner  quick  matrix  aquarium  genact  train   random" ;;
        *)        echo "使い方: intro [banner|quick|matrix|aquarium|genact|train|random|list]" ;;
    esac
}
# ---------- 必ず最後 ----------
source ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

_lap syntax-highlighting


# fishの標準配色に合わせる(色番号は ANSI: 1=red 2=green 3=yellow 6=cyan 9=brred 14=brcyan)
ZSH_HIGHLIGHT_STYLES[command]='fg=default'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=default'
ZSH_HIGHLIGHT_STYLES[alias]='fg=default'
ZSH_HIGHLIGHT_STYLES[function]='fg=default'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=default'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=default'
ZSH_HIGHLIGHT_STYLES[default]='fg=6'                       # 引数 (fish_color_param)
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=6'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=6'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=3'        # 引用符 (fish_color_quote)
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[comment]='fg=1'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=2'              # ; && | (fish_color_end)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9'                 # エラー (fish_color_error)
ZSH_HIGHLIGHT_STYLES[redirection]='fg=6,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=14'                     # * ? など (fish_color_operator)
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=14'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=14'  # 文字列内のエスケープ (fish_color_escape)
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=14'
ZSH_HIGHLIGHT_STYLES[path]='underline'                     # 存在するパス (fish_color_valid_path)

# ---------- 起動時の演出 ----------
# 対話シェルの最上位、かつnvim内のターミナルではないときだけ流す
if [[ -o interactive && -z $NVIM && -z $TMUX && $SHLVL -le 1 ]]; then
    fastfetch
fi

