#!/bin/bash
# Update
brew update

# Upgrade
brew upgrade

# Tap
brew tap homebrew/apache
brew tap homebrew/boneyard
brew tap homebrew/dupes
brew tap homebrew/php
brew tap homebrew/python
brew tap homebrew/science
brew tap homebrew/versions
brew tap ymyzk/ymyzk

# Packages
brew install binutils
brew install carthage
brew install closure-compiler
brew install coq
brew install coreutils
brew install emacs --with-cocoa
brew install exiftool
brew install ffmpeg --with-faac --with-fdk-aac --with-ffplay --with-fontconfig --with-freetype --with-frei0r --with-libass --with-libbluray --with-libcaca --with-libquvi --with-libsoxr --with-libssh --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools --with-webp --with-x265
brew install gauche
# For OpenMP (--without-multilib)
brew install gcc --without-multilib
brew install ghc
brew install git
brew install gnu-sed
brew install gnupg
brew install go
brew install graphicsmagick --with-ghostscript --with-jasper --with-libtiff --with-libwmf --with-little-cms --with-little-cms2 --with-perl --with-webp --with-x11
brew install graphviz --with-app
brew install heroku-toolbelt
brew install htop
brew install hub
brew install imagemagick --with-fftw --with-fontconfig --with-ghostscript --with-hdri --with-jp2 --with-liblqr --with-librsvg --with-libtiff --with-libwmf --with-little-cms --with-little-cms2 --with-openexr --with-pango --with-perl --with-webp --with-x11
brew install juman
brew install llvm33
brew install llvm36
brew install mecab
brew install mecab-ipadic
brew install mercurial
brew install mongodb
brew install mysql
brew install nasm
brew install neovim --HEAD
brew install nkf
brew install nmap
brew install nvm
brew install ocaml
brew install opam
brew install opencv
brew install opencv3 --with-python3
brew install peco
brew install php56
brew install proof-general --with-emacs=/usr/local/bin/emacs
brew install pypy
brew install pypy3
brew install python
brew install python3
brew install qemu
brew install r
brew install racket
brew install reattach-to-user-namespace
brew install rlwrap
brew install ruby
brew install rust
brew install sl
brew install sqlite
brew install tig
brew install tmux
brew install tree
brew install unrar
brew install vim --with-luajit --HEAD
brew install watch
brew install wget
# needs additional setting
brew install zsh
brew install zsh-completions
