#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh;

function main() {
  if [ -z "$1" ]
  then
    git checkout -- .
  else
    git checkout -- $@
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
