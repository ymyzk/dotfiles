# dotfiles
My dotfiles.

* Git
* Screen
* Tmux
* Vim
* Zsh

## Usage
### Install
```
cd ~
git clone https://github.com/ymyzk/dotfiles.git .dotfiles
cd .dotfiles
git submodule init
git submodule update
./install.sh dotfiles.txt
```

### Update
```
cd ~
cd .dotfiles
git pull --rebase
./install.sh dotfiles.txt
```
