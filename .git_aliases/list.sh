#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  local commit
  if [ -z "$1" ]
  then
    commit=`git log -n 1 | grep -Poe "^commit .+" | sed -e "s/commit \(.\+\)/\1/"`
  else
    commit=$1
  fi
  local list=$(git show --pretty="format:" --name-only "$commit")
  printC $commit
  printf '%s\n' "${list[@]}"
}

if ! helpMode $@ `basename $0`
then
  main $@
fi