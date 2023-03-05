if _command_exists fzf; then
  function _fzf-select-history() {
    BUFFER=$(\history -n 1 | awk '!a[$0]++' | fzf --tac --reverse --prompt="HISTORY> " --query="$LBUFFER")
    CURSOR=$#BUFFER
  }
  zle -N _fzf-select-history
  bindkey '^r' _fzf-select-history
fi
