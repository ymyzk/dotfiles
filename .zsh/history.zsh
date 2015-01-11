HISTFILE=~/.zsh_history
# Memory
HISTSIZE=3000
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
