alias tmux='tmux -2'

alias -s js=node
alias -s py=python
alias -s txt=cat

if [ $uname = 'Darwin' ]; then
    alias ls='ls -G'
    alias brew="env PATH=${PATH/:$HOME\/\.pyenv\/shims/} brew"

    # Browsers
    alias canary='open -a Google\ Chrome\ Canary'
    alias chrome='open -a Google\ Chrome'
    alias firefox='open -a Firefox'
    alias safari='open -a Safari'

    # OS X
    alias ios-simulator='open $(xcode-select -p)/Applications/iOS\ Simulator.app'
    alias rm-open-in-duplicates="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"

    alias -s {png,jpg,bmp,pdf,PNG,JPG,BMP,PDF}='open -a Preview'
elif [ $uname = 'Linux' ]; then
    alias ls='ls --color'

    if command_exists gnome-open; then
        alias open='gnome-open'
    fi
    if command_exists xsel; then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
    fi

    alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
fi

# 各種圧縮ファイルの解凍
function extract() {
    case $1 in
        *.tar.gz|*.tgz) tar xzvf $1;;
        *.tar.xz) tar Jxvf $1;;
        *.zip) unzip $1;;
        *.lzh) lha e $1;;
        *.tar.bz2|*.tbz) tar xjvf $1;;
        *.tar.Z) tar zxvf $1;;
        *.gz) gzip -dc $1;;
        *.bz2) bzip2 -dc $1;;
        *.Z) uncompress $1;;
        *.tar) tar xvf $1;;
        *.arj) unarj $1;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
