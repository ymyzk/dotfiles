# YO_API_TOKEN is required.
# Get it from https://dev.justyo.co/

YO_API_URL='https://api.justyo.co/yo/'
YO_HISTORY_FILE="$HOME/.yo_zsh_history"

function sendyo() {
  local location url username
  local -a usernames
  local request_command message response
  local -a success_usernames
  local opt
  local color_clear='\e[0m'
  local color_ok='\e[0;32m'
  local color_fail='\e[0;31m'
  local tmpfile=$(mktemp 2>/dev/null || mktemp -t yo_zsh)

  # Parse arguments
  for opt in "$@"; do
    case $opt in
      '-h'|'--help')
        echo "usage: $0 [options] username ..."
        echo
        echo "Options:"
        echo "  --help, -h"
        echo "      Show help"
        echo "  --location {lat,lon}, -l {lat,lon}"
        echo "      Send Yo Location"
        echo "  --url {url}, -u {url}"
        echo "      Send Yo Link"
        return 1
        ;;
      '-l'|'--location')
        if [[ -z "$2" ]]; then
          echo "requires argument"
          return 1
        fi
        location="$2"
        shift 2
        ;;
      '-u'|'--url')
        if [[ -z "$2" ]]; then
          echo "requires argument"
          return 1
        fi
        url="$2"
        shift 2
        ;;
      -*)
        echo "illegal option"
        return 1
        ;;
      *)
        if [[ -n "$1" ]]; then
          usernames+=($(echo $1 | tr '[:lower:]' '[:upper:]'))
          shift 1
        fi
        ;;
    esac
  done

  for username in $usernames; do
    # Prepare request
    if [[ -n "$location" ]]; then
      message="Yo Location! $location $username"
      request_command="curl --silent --write-out %{http_code} --output ${tmpfile} -d api_token=$YO_API_TOKEN -d username=$username $YO_API_URL -d 'location=$location'"
    elif [[ -n "$url" ]]; then
      message="Yo Link! $url $username"
      request_command="curl --silent --write-out %{http_code} --output ${tmpfile} -d api_token=$YO_API_TOKEN -d username=$username $YO_API_URL -d 'link=$url'"
    else
      message="Yo! $username"
      request_command="curl --silent --write-out %{http_code} --output ${tmpfile} -d api_token=$YO_API_TOKEN -d username=$username $YO_API_URL"
    fi

    # Send request
    printf "[....] $message"
    response=$(eval "$request_command")

    # Show result
    if [ $response = '200' ]; then
      printf "\r[ ${color_ok}OK${color_clear} ] $message\n"
      success_usernames=($success_usernames $username)
    else
      printf "\r[${color_fail}FAIL${color_clear}] $message\n"
      cat "$tmpfile"
      echo
    fi
  done

  if [ -e $tmpfile ]; then
    rm "$tmpfile"
  fi

  _sendyo_save_history $success_usernames
}

function _sendyo_load_history() {
  if [ ! -e $YO_HISTORY_FILE ]; then
    touch $YO_HISTORY_FILE
  fi
  _sendyo_usernames=(${(@f)"$(< $YO_HISTORY_FILE)"})
}

function _sendyo_save_history() {
  if [ -z "${_sendyo_usernames+x}" ]; then
    _sendyo_load_history
  fi
  # Update cache
  _sendyo_usernames=($_sendyo_usernames $@)
  # Remove duplicates and save to file
  echo $_sendyo_usernames | tr ' ' '\n' | awk '!a[$0]++' > $YO_HISTORY_FILE
}

function _sendyo_args() {
  if [ -z "${_sendyo_usernames+x}" ]; then
    _sendyo_load_history
  fi
  _describe 'yo_usernames' _sendyo_usernames
}

function _sendyo() {
  _arguments \
    '(-h --help)'{-h,--help}'[Show help]' \
    '(-l --location -u --url)'{-l,--location}'[Send Yo Location {lat,lon}]:coordinate:()' \
    '(-l --location -u --url)'{-u,--url}'[Send Yo Link]:url:_urls' \
    '*:args:_sendyo_args'
}

compdef _sendyo sendyo
