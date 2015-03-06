#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  if ! bash $DIR/_beforePush.sh
  then
    return
  fi
  echo "success before push"

  if [ -n "$1" ]
  then
    if [ -n "`git branch | grep -Poe "$1"`" ]
    then
      git push origin $1:$1
    else
      printC "'$1' branch doesn't exist" red;
    fi
  else
    local branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin $branch:$branch
  fi;
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
