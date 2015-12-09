#!/bin/bash
set -eu

packages=(
  'atdgen'
  'core'
  'menhir'
  'merlin'
  'omake'
  'utop'
  'yojson'
)

opam update

echo "Installing packages: ${packages[*]}"
opam install ${packages[*]}
