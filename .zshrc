# .zshrc
#
# Copyright (c) 2012-2013, Yusuke Miyazaki. All rights reserved.

# Language setting
export LANG=ja_JP.UTF-8

# Auto complete
autoload -Uz compinit
compinit

# Prompt
#PROMPT="${HOST%%.*}:%1~ ${USER}%(!.#.$) "
PROMPT="${USER}@${HOST%%.*}: %~
%(!.#.$) "

# Title
# Not working?
#case "${TERM}" in kterm*|xterm)
#    precmd() {
#        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#    }
#;;
#esac

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # Igcore dupulication command History
setopt share_history

# Move current directory without cd command
# setopt auto_cd

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
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

