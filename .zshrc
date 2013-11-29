# .zshrc
#
# Copyright (c) 2012-2013, Yusuke Miyazaki. All rights reserved.

local uname=`uname`

# 言語設定
# 日本語 UTF-8
export LANG=ja_JP.UTF-8

# PATH
# OS X のときは Homebrew のために PATH を変更
if [ $uname = "Darwin" ]; then
    PATH=/usr/local/bin:$PATH
fi
# Linux CUDA 用の PATH
if [ -d "/usr/local/cuda/bin" ]; then
    export PATH=/usr/local/cuda/bin:$PATH
fi
if [ -d "/usr/local/cuda/lib64" ]; then
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi

# エディタ
export EDITOR=vim

# オートコンプリート
autoload -Uz compinit
compinit

# cd コマンドなしでディレクトリを移動する
setopt auto_cd

# ディレクトリスタックに自動で push する
# cd -<TAB> でスタックのリストを確認できる
setopt auto_pushd

# コマンドのオードコレクション
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

# ls コマンドの色分け設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
if [ $uname = "Darwin" ]; then
    alias ls="ls -G"
elif [ $uname = "Linux" ]; then
    alias ls="ls --color"
fi
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # Igcore dupulication command History
setopt share_history

# プロンプト
# user@host
local p_uh="%F{green}%n@%m%f${WINDOW+[$WINDOW]}"
# current directory
local p_cd="%F{cyan}%~%f"
# prefix (root-># user->$)
local p_pr="%(!,#,$)"
# remote host
local p_rh=""

# SSH 経由で接続しているときはリモートホストの情報を追加
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rh=`who am i | sed 's/.*(\(.*\)).*/\1/'`
    rh=${rh#localhost:}
    rh=${rh%%.*}
    p_rh=" %F{yellow}(${rh})%f"
fi

PROMPT="$p_uh$p_rh: $p_cd
$p_pr "

# Suffix alias
alias -s py=python
alias -s txt=cat

if [ $uname = "Darwin" ]; then
    alias -s {png,jpg,bmp,pdf,PNG,JPG,BMP,PDF}='open -a Preview'
else
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

# VCS
RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:*' enable git svn hg bzr

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
