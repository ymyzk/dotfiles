function generate-htpasswd-ssha1() {
    local sedc username password salt sha1

    # OpenSSL check
    hash openssl 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "$cmd requires openssl"
        exit 1
    fi

    # sed check
    if _command_exists gsed; then
        sedc='gsed'
    elif _command_exists seg; then
        sedc='sed'
    else
        exit 1
    fi

    # Username
    printf 'Username: ' 1>&2
    read username

    # Password
    printf 'Password: ' 1>&2
    stty -echo
    read password
    stty echo
    printf '\n' 1>&2

    # Generate
    salt=`openssl rand -base64 10`
    sha1=$(printf "$password$salt" | openssl dgst -binary -sha1 | $sedc 's#$#'"$salt"'#' | base64)
    printf "$username:{SSHA}$sha1\n"
}

