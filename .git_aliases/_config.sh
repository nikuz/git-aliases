#!/usr/bin/env bash

aliasesFolder=".git_aliases"
homeAliasesFolder="$HOME/$aliasesFolder"
readme="README.md"

# modules for aliases work
modules=("_config" "_clean" "_printColor" "_help")
# aliases, which don't need ask user to install
silentAliases=("pl" "ph")