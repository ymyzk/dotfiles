#!/bin/bash

packages=(
  'bower'
  'browserify'
  'typescript'
  'yarn'
)

echo "Updating npm"
npm install -g npm

echo "Installing packages: ${packages[*]}"
npm install -g ${packages[*]}
