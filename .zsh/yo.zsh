YO_API_URL='https://api.justyo.co/yo/'

function _send-yo() {
    if [ $# -gt 0 ]; then
        curl -s -d "api_token=$YO_API_TOKEN" -d "username=$1" $YO_API_URL
    fi
}

function send-yo() {
    local username
    if [ $# -lt 1 ]; then
        echo "usage: $0 username ..."
    else
        for username in $@; do
            _send_yo $username > /dev/null
        done
    fi
}
