# .zshrc
#
# Copyright (c) 2012-2013, Yusuke Miyazaki. All rights reserved.

# Language setting
export LANG=ja_JP.UTF-8

# Editor setting
export EDITOR=vim

# Auto complete
autoload -Uz compinit
compinit

# Prompt
local p_uh="%n@%m${WINDOW+[$WINDOW]}"
local p_cd="%B%F{blue}%~%f%b"
local p_pr="%(!,#,$)"
PROMPT="$p_uh: $p_cd
$p_pr "

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # Igcore dupulication command History
setopt share_history

# Move current directory without cd command
setopt auto_cd

# Remember current directories
# cd -<TAB>
setopt auto_pushd

# Auto correction
setopt correct

# No beep on completion
setopt nolistbeep

# Predict completion
#autoload predict-on
#predict-on

# Color
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls="ls -G"
alias gls="gls --color"
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

setopt noautoremoveslash

# Git
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
    local name st color gitdir action
    if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
        return
    fi

    name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
    if [[ -z $name ]]; then
        return
    fi

    gitdir=`git rev-parse --git-dir 2> /dev/null`
    action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi

    echo "${color}(git)-[$name]$action%f%b"
}

setopt prompt_subst

RPROMPT='`rprompt-git-current-branch`'

# Old Git
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' formats '(%s)-[%b]'
#zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
#precmd () {
#    psvar=()
#    LANG=en_US.UTF-8 vcs_info
#    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
#}
#RPROMPT="%1(v|%F{green}%1v%f|)"

# Suffix alias
alias -s py=python

if [ `uname` = "Darwin" ]; then
    alias -s {png,jpg,bmp,PNG,JPG,BMP}='open -a Preview'
else
    alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
fi

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

