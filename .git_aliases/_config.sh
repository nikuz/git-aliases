#!/usr/bin/env bash

aliasesFolder=".git_aliases"
homeAliasesFolder="$HOME/$aliasesFolder"

# modules for aliases work
modules=("_config" "_clean" "_printColor")
# aliases, which don't need ask user to install
silentAliases=("pl" "ph")