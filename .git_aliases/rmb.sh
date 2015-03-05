#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  local branches=$@
  if [ -n "$branches" ]
  then
    local curBranch=$(git rev-parse --abbrev-ref HEAD)
    for branch in ${branches[@]}
    do
      if [ "$branch" != "master" ] && [ "$branch" != "$curBranch" ]
      then
        git branch -D $branch
      fi
    done
  else
    git branch | grep -Pv "master|\*" | xargs git branch -D
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
