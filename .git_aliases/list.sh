#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh

name="list"
description="list description"

function main(){
  echo "list"
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
  printC $name
  echo $description
  printC $DIR/$name.sh gray
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi