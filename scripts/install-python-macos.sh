#!/bin/bash
set -eu

set +u
version=$1
set -u
if [ -z "$version" ]; then
  echo "usage: $0 <version>"
  exit 1
fi

current_dir=$(pwd)
temp_dir=$(mktemp -d)
install_dir="/opt/python/$version"
short_version=$(echo "$version" | cut -f 1 -d a | cut -f 1 -d b | cut -f 1 -d r)

export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include"
export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib"

echo "Using temp dir: $temp_dir"
cd "$temp_dir"

wget -O source.tar.xz "https://www.python.org/ftp/python/$short_version/Python-$version.tar.xz"
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
