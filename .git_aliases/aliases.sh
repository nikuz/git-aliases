#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_config.sh
source $DIR/_printColor.sh
source $DIR/_help.sh;

function main(){
  for file in $homeAliasesFolder/*
  do
    local fileName=$(basename "$file")
    fileName="${fileName%.*}"
    if [ -z "`echo $fileName | grep -Poe "^_"`" ]
    then
      helpAliases "$fileName"
      echo ""
    fi
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
  filename=`basename $0`
  helpAliases "${filename%.*}"
  printC $DIR/$name.sh gray
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi