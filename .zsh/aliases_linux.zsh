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

function apt-list-obsolute-packages() {
  if _command_exists aptitude; then
    aptitude search '~o'
  elif _command_exists apt-show-versions; then
    apt-show-versions | grep 'No available version'
  else
    false
  fi
}
