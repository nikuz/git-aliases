#!/usr/bin/env bash

name="aliases"
description="aliases description"

function main(){
  source _config.sh;

  for file in $homeAliasesFolder/*
  do
    bash /$file -h
    echo ""
  done
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