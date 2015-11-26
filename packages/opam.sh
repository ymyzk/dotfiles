#!/bin/bash
set -eu

packages=(
  'core'
  'menhir'
  'merlin'
  'utop'
)

opam update

echo "Installing packages: ${packages[*]}"
opam install ${packages[*]}
