# Aliases

alias ls='ls -G'
alias ll='ls -G -al'

alias canary='open -a Google\ Chrome\ Canary'
alias chrome='open -a Google\ Chrome'
alias firefox='open -a Firefox'
alias safari='open -a Safari'
alias cot='open -a CotEditor'
alias skim='open -a Skim'

# Wrap commands for tmux
if _command_exists reattach-to-user-namespace; then
  alias launchctl='reattach-to-user-namespace launchctl'
  alias pbcopy='reattach-to-user-namespace pbcopy'
  alias pbpaste='reattach-to-user-namespace pbpaste'
fi

# Suffix aliases

alias -s html=open
alias -s {png,jpg,bmp,pdf,PNG,JPG,BMP,PDF}='open -a Preview'

# Useful commands

alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias ios-simulator='open $(xcode-select -p)/Applications/Simulator.app'
alias watch-simulator='open $(xcode-select -p)/Applications/Simulator\ \(Watch\).app'
alias rm-open-in-duplicates="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias osx-sleep="osascript -e 'tell application \"Finder\" to sleep'"
alias show-udids='system_profiler SPUSBDataType | sed -n -e "/iPad/,/Serial/p" -e "/iPhone/,/Serial/p" | grep "Serial Number:" | awk -F ": " "{print $2}"'
