#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh;

function main() {
  if bash _clean.sh
  then
    git fetch origin $1:$1
    git checkout $1
    git branch
  else
    git status
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
