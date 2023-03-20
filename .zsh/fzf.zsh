if _command_exists fzf; then
  function _fzf-select-history() {
    # Remove index from history, remove duplicates, then trigger fzf
    BUFFER=$(\history -n 1 | awk '!a[$0]++' | fzf --tac --reverse --tiebreak=index --prompt="HISTORY> " --query="$LBUFFER")
    CURSOR=$#BUFFER
  }
  zle -N _fzf-select-history
  bindkey '^r' _fzf-select-history
fi
