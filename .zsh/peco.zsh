if _command_exists peco; then
    function _peco-select-history() {
        local tac
        if _command_exists tac; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(\history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
    }
    zle -N _peco-select-history
    bindkey '^r' _peco-select-history

    function _peco-ssh-select-host() {
        local host
        echo "$LBUFFER"
        host=$(grep -iE '^host' ~/.ssh/config | awk '{print $2}' | peco)
        if [ "$host" != '' ]; then
            ssh $@ $host
        fi
    }
    alias ssh-peco=_peco-ssh-select-host
fi
