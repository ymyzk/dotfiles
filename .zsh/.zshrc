# .zshrc
#
# Copyright (c) 2012-2015, Yusuke Miyazaki.

# Profiling
#zmodload zsh/zprof && zprof

# ----- Helper -----

local uname=`uname`

function _command_exists() {
    hash "$1" 2>/dev/null
}

function _add_path_if_exists() {
    if [ -d "$1" ]; then
        export PATH="$1:$PATH"
    fi
}

function _add_fpath_if_exists() {
    if [ -d "$1" ]; then
        export FPATH="$1:$FPATH"
    fi
}

function _add_ld_library_path_if_exists() {
    if [ -d "$1" ]; then
        export LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH"
    fi
}

function _load_library() {
    if [ -f $1 ]; then
        . $1
    fi
}

# ----- / Helper -----

# ----- Environment variables -----

# PATH
# Homebrew
_add_path_if_exists /usr/local/bin
_add_path_if_exists /usr/local/sbin
# Linuxbrew
_add_path_if_exists $HOME/.linuxbrew/bin
# Brew
if _command_exists brew; then
    export HOMEBREW_VERBOSE=true
    export HOMEBREW_NO_ANALYTICS=1
fi
# Linux CUDA
_add_path_if_exists /usr/local/cuda/bin
_add_ld_library_path_if_exists /usr/local/cuda/lib64
# Android on OS X
if [ -d $HOME/Library/Android/sdk ]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  _add_path_if_exists "$ANDROID_HOME/tools"
  _add_path_if_exists "$ANDROID_HOME/platform-tools"
fi
# Go
if [ -d $HOME/Development/Go ]; then
    export GOPATH=$HOME/Development/Go
    _add_path_if_exists $HOME/Development/Go/bin
fi
# Rust
_add_path_if_exists $HOME/.cargo/bin
# Home
_add_path_if_exists $HOME/.local/bin
_add_ld_library_path_if_exists $HOME/.local/lib

# Node Version Manager
# OS X (Homebrew)
if [ $uname = 'Darwin' ] && _command_exists brew && [ $(brew --prefix nvm)/nvm.sh ]; then
    export NVM_DIR=~/.nvm
    # Lazy
    nvm() {
        unset -f nvm
        source $(brew --prefix nvm)/nvm.sh
        nvm "$@"
    }
fi
# Linux
if [ $uname = 'Linux' ] && [ -e "${HOME}/.nvm/nvm.sh" ]; then
    # Lazy
    nvm() {
        unset -f nvm
        source ~/.nvm/nvm.sh
        nvm "$@"
    }
fi

# nodebrew
_add_path_if_exists $HOME/.nodebrew/current/bin

# virtualenvwrapper
if _command_exists virtualenvwrapper_lazy.sh; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Development
    source virtualenvwrapper_lazy.sh
fi

# Google Cloud SDK
if [ -e ~/Applications/google-cloud-sdk/path.zsh.inc ]; then
    source ~/Applications/google-cloud-sdk/path.zsh.inc
fi

# OPAM configuration
if _command_exists opam; then
    eval `opam config env`
fi
if [ -e $HOME/.opam/opam-init/init.zsh ]; then
    . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# Auto completion
# Homebrew
_add_fpath_if_exists /usr/local/share/zsh/site-functions
# zsh-users/zsh-completions
_add_fpath_if_exists /usr/local/share/zsh-completions

# ls コマンドの色分け設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Remove path duplications
typeset -U path cdpath fpath manpath
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path

# ----- / Environment variables -----

# ls コマンドの色分け設定
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cd コマンドなしでディレクトリを移動する
setopt auto_cd

# ディレクトリスタックに自動で push する
# cd -<TAB> でスタックのリストを確認できる
setopt auto_pushd

# Auto completion
autoload -Uz compinit
compinit

# コマンドのオートコレクション
# オートコレクションを実行してほしくないときは
# nocorrect <command> とする
setopt correct

# リストを詰めて表示
setopt list_packed

# ビープ音を鳴らさない
setopt nobeep
setopt nolistbeep

# 末尾の / を自動的に削除しない
setopt noautoremoveslash

# Emacs キーバインド
bindkey -e

# 標準のキーバインドだと, 履歴を見る際にカーソルが先頭に移動する挙動を修正
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Incremental history search
bindkey '^R' history-incremental-search-backward

autoload -Uz zmv

_load_library /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

_load_library $ZDOTDIR/aliases.zsh
_load_library $ZDOTDIR/completion.zsh
_load_library $ZDOTDIR/history.zsh
_load_library $ZDOTDIR/prompt.zsh
_load_library $ZDOTDIR/rprompt.zsh
_load_library $ZDOTDIR/peco.zsh
_load_library $ZDOTDIR/tmux.zsh
_load_library $ZDOTDIR/yo/yo.zsh

_load_library $ZDOTDIR/local.zsh

# Profiling
#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
