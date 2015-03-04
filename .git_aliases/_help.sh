#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_config.sh
source $DIR/_printColor.sh

# arguments:
# 1) alias name
helpAliases(){
  local aliasName=$1
  local helpFile=$homeAliasesFolder/$readme
  local title=$(cat $helpFile | grep -iPoe "^$aliasName$")
  local isStarted
  local matchedLines=0

  cat $helpFile | while read line
  do
    if [ "`echo $line | grep -iPoe "^$aliasName$"`" ]
    then
      printC $line
      isStarted=true
    fi

    if [ $isStarted ] && [ "`echo $line | grep -iPoe "^- - -$"`" ]
    then
      break
    fi

    if [ $isStarted ] && [ $matchedLines -gt 1 ] && [ -n "`echo $line`" ]
    then
      echo $line
    fi

    if [ $isStarted ]
    then
      (( matchedLines++ ))
    fi
  done
}

helpCopy(){
  cp $DIR/../$readme $homeAliasesFolder/$readme
}

