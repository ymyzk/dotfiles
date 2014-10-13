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
if [ -d '/usr/local/cuda/bin' ]; then
    export PATH=/usr/local/cuda/bin:$PATH
fi
if [ -d '/usr/local/cuda/lib64' ]; then
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi

# Node Version Manager
# OS X (Homebrew)
if [ -x "`which brew 2>/dev/null`" ]; then
    source $(brew --prefix nvm)/nvm.sh
    export NVM_DIR=~/.nvm
fi
# Linux
if [ $uname = 'Linux' -a -e "${HOME}/.nvm/nvm.sh" ]; then
    source ~/.nvm/nvm.sh
fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Google Cloud SDK.
if [ -e '~/Development/google-cloud-sdk/path.zsh.inc' ]; then
    source '~/Development/google-cloud-sdk/path.zsh.inc'
fi

# Auto completion
# Homebrew の site-functions を追加
if [ -d '/usr/local/share/zsh/site-functions' ]; then
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

# プロンプト
# user@host
local p_uh="%F{green}%n@%m%f${WINDOW+[$WINDOW]}"
# current directory
local p_cd="%F{cyan}%~%f"
# prefix (root-># user->$)
local p_pr="%(!,#,$)"
# remote host
local p_rh=''

# SSH 経由で接続しているときはリモートホストの情報を追加
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rh=`who am i | sed 's/.*(\(.*\)).*/\1/'`
    rh=${rh#localhost:}
    rh=${rh%%.*}
    p_rh=" %F{yellow}(${rh})%f"
fi

PROMPT="$p_uh$p_rh: $p_cd
$p_pr "

# ----- Alias -----

alias tmux='tmux -2'

alias -s txt=cat

if [ $uname = 'Darwin' ]; then
    alias ls='ls -G'
    alias rm-open-in-duplicates="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
    alias brew="env PATH=${PATH/:$HOME\/\.pyenv\/shims/} brew"
    alias -s {png,jpg,bmp,pdf,PNG,JPG,BMP,PDF}='open -a Preview'
elif [ $uname = 'Linux' ]; then
    alias ls='ls --color'

    if [ -x "`which gnome-open 2>/dev/null`" ]; then
        alias open='gnome-open'
    fi
    if [ -x "`which xsel 2>/dev/null`" ]; then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
    fi

    alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
fi

# 各種圧縮ファイルの解凍
function extract() {
    case $1 in
        *.tar.gz|*.tgz) tar xzvf $1;;
        *.tar.xz) tar Jxvf $1;;
        *.zip) unzip $1;;
        *.lzh) lha e $1;;
        *.tar.bz2|*.tbz) tar xjvf $1;;
        *.tar.Z) tar zxvf $1;;
        *.gz) gzip -dc $1;;
        *.bz2) bzip2 -dc $1;;
        *.Z) uncompress $1;;
        *.tar) tar xvf $1;;
        *.arj) unarj $1;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

# ----- / Alias -----

# pip zsh completion start
function _pip_completion {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
               COMP_CWORD=$(( cword-1 )) \
               PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

# The next line enables bash completion for gcloud.
if [ -e '~/Development/google-cloud-sdk/completion.zsh.inc' ]; then
    source '~/Development/google-cloud-sdk/completion.zsh.inc'
fi

# VCS
RPROMPT=''

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git svn hg bzr

# For non Git VCS
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

# Git
if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%m%c%u'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%m%c%u' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
fi

# Hooks
if is-at-least 4.3.11; then
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-nomerge-branch

    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            return 1
        fi

        return 0
    }

    function +vi-git-untracked() {
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then
            hook_com[unstaged]+='?'
        fi
    }

    function +vi-git-nomerge-branch() {
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            hook_com[misc]+="m${nomerged} "
        fi
    }
fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt
    local vcs_info_bold
    local vcs_info_color

    LANG=en_US.UTF-8 vcs_info

    vcs_info_bold=false

    case $vcs_info_msg_1_ in
        *'+'*'?'*)
            vcs_info_color=red
            vcs_info_bold=true ;;
        *'-'*'?'*)
            vcs_info_color=magenta
            vcs_info_bold=true ;;
        *'+'*)
            vcs_info_color=red ;;
        *'-'*)
            vcs_info_color=magenta ;;
        *'?'*)
            vcs_info_color=yellow ;;
        *)
            vcs_info_color=green ;;
    esac

    if [[ -z ${vcs_info_msg_0_} ]]; then
        prompt=""
    else
        if [ $vcs_info_color != 'green' ]; then
            vcs_info_msg_1_=$vcs_info_msg_1_' '
        fi
        prompt="%F{$vcs_info_color}${vcs_info_msg_1_}${vcs_info_msg_0_}${vcs_info_msg_2_}%f"
        if $vcs_info_bold; then
            prompt='%B'${prompt}'%b'
        fi
    fi
    RPROMPT="$prompt"
}

add-zsh-hook precmd _update_vcs_info_msg
