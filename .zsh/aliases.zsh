alias df='df -h'
alias tmux='tmux -2'

alias -s js=node
alias -s py=python
alias -s txt=cat

if [ $uname = 'Darwin' ]; then
    alias ls='ls -G'
    alias ll='ls -G -al'

    alias canary='open -a Google\ Chrome\ Canary'
    alias chrome='open -a Google\ Chrome'
    alias firefox='open -a Firefox'
    alias safari='open -a Safari'
    alias cot='open -a CotEditor'

    alias ios-simulator='open $(xcode-select -p)/Applications/iOS\ Simulator.app'
    alias rm-open-in-duplicates="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
    alias osx-sleep="osascript -e 'tell application \"Finder\" to sleep'"

    alias -s html=open
    alias -s {png,jpg,bmp,pdf,PNG,JPG,BMP,PDF}='open -a Preview'

    # iOS Device UDID
    function show-udids() {
        system_profiler SPUSBDataType | sed -n -e '/iPad/,/Serial/p' -e '/iPhone/,/Serial/p' | grep "Serial Number:" | awk -F ": " '{print $2}'
    }
elif [ $uname = 'Linux' ]; then
    alias ls='ls --color'
    alias ll='ls --color -al'

    if _command_exists xdg-open; then
        alias open='xdg-open'
    elif _command_exists gnome-open; then
        alias open='gnome-open'
    fi
    if _command_exists xsel; then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
    fi

    alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
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

alias generate-django-secret-key="python -c \"import random; print(''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50)))\""
