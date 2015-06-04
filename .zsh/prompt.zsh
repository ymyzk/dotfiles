# user@host
local p_uh="%(?.%F{green}.%F{magenta})%n@%m%f${WINDOW+[$WINDOW]}"
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
