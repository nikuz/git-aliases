#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  if [ -n "$1" ]
  then
    git pull origin $1:$1
  else
    git pull origin $(git rev-parse --abbrev-ref HEAD)
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
