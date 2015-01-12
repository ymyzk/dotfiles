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
    zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-untracked git-nomerge-branch

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
