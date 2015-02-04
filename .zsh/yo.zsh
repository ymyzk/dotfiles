# YO_API_TOKEN is required.
# Get it from https://dev.justyo.co

YO_API_URL='https://api.justyo.co/yo/'

function _send-yo() {
    # Check arguments
    if [ $# -lt 2 ]; then
        return
    fi

    local request_command
    local message
    local response
    local yo_type=$1
    local username=$(echo $2 | tr '[:lower:]' '[:upper:]')

    # Parse arguments
    case $yo_type in
        yo)
            message="Yo! $username"
            request_command="curl --silent --write-out %{http_code} --output /dev/null -d api_token=$YO_API_TOKEN -d username=$username $YO_API_URL"
            ;;
        *)
            echo "Unrecognized Yo type: $yo_type" 1>&2
            return
            ;;
    esac

    # Send request
    printf "[....] $message"
    response=$(eval "$request_command")

    # Show result
    if [ $response = '200' ]; then
        printf "\r[ OK ] $message\n"
    else
        printf "\r[FAIL] $message\n"
    fi
}

function send-yo() {
    local username
    if [ $# -lt 1 ]; then
        echo "usage: $0 username ..."
    else
        for username in $@; do
            _send-yo 'yo' $username
        done
    fi
}
