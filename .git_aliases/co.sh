#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh;

function main(){
  local branch=$(git rev-parse --abbrev-ref HEAD)
  printC "Current branch is $branch"
  git pl
  wait $pid
  printC "============================================"
  git status
}

for i in $@
do
  if [ "$i" == "-h" ]
  then
    helpMode=true;
  fi;
done

if [ -n "$helpMode" ]
then
  filename=`basename $0`
  helpAliases "${filename%.*}"
  printC $DIR/$name.sh gray
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi
