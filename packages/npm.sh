#!/bin/bash

packages=(
  'babel-cli'
  'bower'
  'browserify'
  'coffee-script'
  'eslint'
  'generator-hubot'
  'grunt-cli'
  'jshint'
  'typescript'
  'yo'
)

echo "Updating npm"
npm install -g npm

echo "Installing packages: ${packages[*]}"
npm install -g ${packages[*]}
