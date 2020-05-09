#!/bin/bash
set -eu

packages=(
  'atdgen'
  'core'
  'flowtype'
  'jbuilder'
  'js_of_ocaml'
  'menhir'
  'merlin'
  'ocamlspot'
  'ocp-indent'
  'omake'
  'ott'
  'ounit'
  'utop'
  'yojson'
)

opam update

echo "Installing packages: ${packages[*]}"
opam install ${packages[*]}
