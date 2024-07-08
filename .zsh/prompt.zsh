# user@host
local p_uh="%(?.%F{green}.%F{magenta})%n@%m%f${WINDOW+[$WINDOW]}"
# current directory
local p_cd="%F{cyan}%~%f"
# prefix (root-># user->$)
local p_pr="%(!,#,$)"

PROMPT="$p_uh: $p_cd
$p_pr "
