#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main() {
  if [ -n "`st | grep -Poe "Untracked"`" ]
  then
    git add .
  fi
  if [ -z "$1" ]
  then
    git stash
  elif [[ -n "$1" && -z "$2" ]]
  then
    git stash "$1" stash@{0}
  elif [ -n "$2" ]
  then
    git stash "$1" stash@{"$2"}
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
