#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  local branch=$(git rev-parse --abbrev-ref HEAD)
  printC "Current branch is $branch"
  git pull origin $branch:$branch
  wait $pid
  printC "============================================"
  git status
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
