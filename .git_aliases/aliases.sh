#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_config.sh
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  local folder
  if [ -d $homeAliasesFolder ]
  then
    folder=$homeAliasesFolder
  else
    folder=$aliasesFolder
  fi

  for file in $folder/*.sh
  do
    local fileName=$(basename "$file")
    if [ -z "`echo $fileName | grep -Poe "^(_|README)"`" ]
    then
      helpMode -h "$fileName"
      echo ""
    fi
  done
}

if ! helpMode $@ `basename $0`
then
  main $@
fi