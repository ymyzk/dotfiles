if command_exists tmux; then
    function tmux-change-prefix() {
        local old_prefix=$(tmux list-keys | grep 'send-prefix' | tr -s ' ' | cut -d ' ' -f 2)
        local new_prefix='C-b'
        local user_prefix=''

        # Wait user input if prefix key is not specified
        if [ "$1" = '' ]; then
            printf "Select prefix key (default: C-b): C-"
            read -k 1 user_prefix
            printf "\n"
            if [ "$user_prefix" = '' ]; then
                new_prefix='C-b'
            else
                new_prefix="C-$user_prefix"
            fi
        fi

        # Change prefix key
        tmux unbind $old_prefix
        tmux set -g prefix $new_prefix &> /dev/null
        tmux bind $new_prefix send-prefix

        # Update status line
        tmux refresh -S

        # Message
        echo "Changed tmux prefix key: $old_prefix -> $new_prefix"
    }
fi
