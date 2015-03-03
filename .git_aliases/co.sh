#!/usr/bin/env bash

name="co"
description="co description"

function main(){
  echo "co"
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
