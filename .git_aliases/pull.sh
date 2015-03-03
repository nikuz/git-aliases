#!/usr/bin/env bash

name="aliases"
description="aliases description"

function main(){
  local branch=$(git branch | grep -Poe "\*.+" | sed 's/\* //')
  if [ -z "$1" ]
  then
    git pull origin $branch
  else
    git pull origin $1:$1
  fi;
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
  echo $name
  echo $description
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi