#!/bin/bash
set -eu

set +u
version=$1
set -u
if [ -z "$version" ]; then
  exit 1
fi

current_dir=$(pwd)
temp_dir=$(mktemp -d)
install_dir="/opt/python/$version"

LDFLAGS=-L/usr/local/opt/openssl/lib
CPPFLAGS=-I/usr/local/opt/openssl/include

echo "Using temp dir: $temp_dir"
cd "$temp_dir"

wget -O source.tar.xz "https://www.python.org/ftp/python/$version/Python-$version.tar.xz"
tar xf source.tar.xz
cd "Python-$version"

set -x
./configure "--prefix=$install_dir"
make
sudo make install
set +x

echo "Cleaning up..."
cd "$current_dir"
sudo rm -rf $temp_dir
