#!/usr/bin/env bash

aliasesFolder=".git_aliases"
homeAliasesFolder="$HOME/$aliasesFolder"
readme="README.md"

# modules for aliases work
modules=("_config" "_clean" "_printColor" "_help" "_beforePush" "_printMultiline")
# modules, which will be executed before push branch to origin
beforePushModules=("__grunt")