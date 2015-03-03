#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh

name="go"
description="Git checkout"

function main(){
  if [ -n "`git branch | grep -Poe "$1"`" ]
  then
      git checkout $1;
  else
      printC "'$1' branch doesn't exist" red;
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
  printC $name
  echo $description
  printC $DIR/$name.sh gray
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi
