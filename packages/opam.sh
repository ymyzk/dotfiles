#!/bin/bash
set -eu

packages=(
  'atdgen'
  'core'
  'flowtype'
  'menhir'
  'merlin'
  'ocamlspot'
  'omake'
  'ounit'
  'utop'
  'yojson'
)

opam update

echo "Installing packages: ${packages[*]}"
opam install ${packages[*]}
