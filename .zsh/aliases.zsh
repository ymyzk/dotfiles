# Aliases

alias df='df -h'
alias tmux='tmux -2'

if _command_exists stack; then
  alias ghc='stack ghc --'
  alias ghci='stack ghci --'
  alias runghc='stack runghc --'
  alias runhaskell='stack runhaskell --'
fi

# rlwrap
if _command_exists rlwrap; then
  if _command_exists ochacaml; then
    alias ochacaml='rlwrap ochacaml'
  fi

  if _command_exists racket; then
    alias racket='rlwrap racket'
    alias tracket='rlwrap racket -I typed/racket'
  fi
fi

if _command_exists python3; then
  alias http-server="python3 -m http.server --bind 127.0.0.1"
elif _command_exists python2; then
  alias http-server="python2 -m SimpleHTTPServer"
fi

alias generate-django-secret-key="python -c \"import random; print(''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50)))\""
alias remove-docker-dangling-images='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias global-ip='curl -s http://checkip.amazonaws.com/ | tr -d "\n"'
alias global-host='global-ip | xargs host'

nodebrew-install-latest-binary() {
  if [ -z "$1" ]; then
    echo "Usage: nodebrew-install-latest-binary <major_version> [<major_version> ...]"
    return 1
  fi

  for major_version in "$@"; do
    local latest_version

    # Fetch the list of available versions
    local versions=$(nodebrew ls-remote 2>/dev/null | tr -s ' ' '\n')

    if [ -z "$versions" ]; then
      echo "Failed to fetch Node.js versions. Ensure nodebrew is installed and working."
      return 1
    fi

    # Extract the latest version for the given major version
    latest_version=$(echo "$versions" | grep -P "v${major_version}\\.\\d+\\.\\d+" | tail -n 1)

    if [ -z "$latest_version" ]; then
      echo "No available versions found for Node.js v${major_version}."
      continue
    fi

    # Check if the latest version is already installed
    local installed_versions=$(nodebrew ls | grep -P "v${major_version}\\.\\d+\\.\\d+")
    if echo "$installed_versions" | grep -q "$latest_version"; then
      echo "Node.js $latest_version is already installed. Skipping installation."
    else
      # Install the latest version
      echo "Installing Node.js $latest_version..."
      nodebrew install-binary "$latest_version"

      if [ $? -eq 0 ]; then
        echo "Node.js $latest_version installed successfully."
      else
        echo "Failed to install Node.js $latest_version."
        continue
      fi
    fi

    # Uninstall older versions of the same major version
    echo "Uninstalling older versions of Node.js v${major_version}..."
    local installed_versions=$(nodebrew ls | grep -P "v${major_version}\\.\\d+\\.\\d+")
    echo "$installed_versions" | while read -r version; do
      if [ "$version" != "$latest_version" ]; then
        echo "Uninstalling $version..."
        nodebrew uninstall "$version"
      fi
    done

    echo "Cleanup complete for Node.js v${major_version}."
  done

  # Use the first major version specified
  local first_major_version="$1"
  echo "Switching to Node.js v${first_major_version}..."
  nodebrew use "v${first_major_version}"
}

# Suffix aliases

alias -s js=node
alias -s txt=cat

if _command_exists python; then
  alias -s py=python
elif _command_exists python3; then
  alias -s py=python3
elif _command_exists python2; then
  alias -s py=python2
fi

# 各種圧縮ファイルの解凍
function _extract() {
  case $1 in
    *tar.bz|*.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar xJvf $1;;
    *.tar.Z|*.taz) tar xzvf $1;;
    *.arj) unarj $1;;
    *.bz2) bzip2 -dc $1;;
    *.gz) gzip -dc $1;;
    *.lzh) lha e $1;;
    *.rar) unrar x $1;;
    *.tar) tar xvf $1;;
    *.xz) xz -dv $1;;
    *.Z) uncompress $1;;
    *.zip) unzip $1;;
  esac
}
alias -s {arz,bz2,gz,lzh,rar,tar,tbz,tgz,xz,Z,zip}=_extract

if [ $uname = 'Darwin' ]; then
  _load_library $ZDOTDIR/aliases_darwin.zsh
elif [ $uname = 'Linux' ]; then
  _load_library $ZDOTDIR/aliases_linux.zsh
fi
