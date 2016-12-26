#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  local branch=$(git rev-parse --abbrev-ref HEAD)

  git pull origin $branch:$branch
  wait $pid
  if [ ! $DIR/_clean.sh ]
  then
    git status
  else
    git checkout master
    wait $pid
    git pull origin master:master
    wait $pid
    if [ ! $DIR/_clean.sh ]
    then
      git status
    else
      git merge $branch
      wait $pid
      if [ ! $DIR/_clean.sh ]
      then
        git status
      else
        git push origin master:master
      fi
    fi
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
