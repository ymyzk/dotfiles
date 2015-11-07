#!/bin/bash

packages=(
  'core'
  'menhir'
  'merlin'
  'utop'
)

echo "Installing packages: ${packages[*]}"
opam install ${packages[*]}
