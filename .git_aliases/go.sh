#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  if [ -n "`git branch | grep -o "$1"`" ]
  then
      git checkout $1
  else
      printC "'$1' branch doesn't exist" red
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
