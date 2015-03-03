#!/usr/bin/env bash

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
  echo $name
  echo $description
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi