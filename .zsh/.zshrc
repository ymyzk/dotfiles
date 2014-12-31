# .zshrc
#
# Copyright (c) 2012-2014, Yusuke Miyazaki.

local uname=`uname`

# ----- Environment variables -----

# Language
# Japanese / JAPAN / UTF-8
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# PATH
# Homebrew
if [ $uname = 'Darwin' ]; then
    export PATH=/usr/local/bin:$PATH
fi
# Linux CUDA
if [ -d /usr/local/cuda/bin ]; then
    export PATH=/usr/local/cuda/bin:$PATH
fi
if [ -d /usr/local/cuda/lib64 ]; then
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi
# Go
if [ -d ~/Development/Go ]; then
    export GOPATH=~/Development/Go
fi

# Node Version Manager
# OS X (Homebrew)
if [ -e $(brew --prefix nvm)/nvm.sh ]; then
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
fi
# Linux
if [ $uname = 'Linux' -a -e "${HOME}/.nvm/nvm.sh" ]; then
    source ~/.nvm/nvm.sh
fi

# pyenv
if [ -x "`which pyenv 2>/dev/null`" ]; then
    eval "$(pyenv init -)"
    # For tmux
    export PATH=$HOME/.pyenv/shims:$PATH
fi
if [ -x "`which pyenv-virtualenv-init 2>/dev/null`" ]; then
    eval "$(pyenv virtualenv-init -)"
fi

# Google Cloud SDK
if [ -e ~/Development/google-cloud-sdk/path.zsh.inc ]; then
    source ~/Development/google-cloud-sdk/path.zsh.inc
fi

# OPAM configuration
if [ -e ~/.opam/opam-init/init.zsh ]; then
    . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# Auto completion
# Homebrew の site-functions を追加
if [ -d /usr/local/share/zsh/site-functions ]; then
    fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

# Editor
export EDITOR=vim

# ls コマンドの色分け設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ----- / Environment variables -----

# Remove path duplications
typeset -U path cdpath fpath manpath

# ls コマンドの色分け設定
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

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

# Vi キーバインド
bindkey -v

# 標準のキーバインドだと, 履歴を見る際にカーソルが先頭に移動する挙動を修正
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# 履歴
HISTFILE=~/.zsh_history
# Memory
HISTSIZE=1000
# File system
SAVEHIST=100000
# 重複する履歴を無視する
setopt hist_ignore_dups
# 履歴をシェル間で共有する
setopt share_history
# 余白を削除
setopt hist_reduce_blanks
# Incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

. $ZDOTDIR/aliases.zsh
. $ZDOTDIR/completion.zsh
. $ZDOTDIR/prompt.zsh
