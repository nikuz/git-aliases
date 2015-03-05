#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_config.sh
source $DIR/_printColor.sh

# arguments:
# 1) alias name
function helpAliases(){
  local aliasName=$1
  local helpFile=$homeAliasesFolder/$readme
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

function helpCopy(){
  cp $DIR/../$readme $homeAliasesFolder/$readme
}

function helpMode(){
  local arguments=($@);
  local helpMode=1

  for i in $arguments
  do
    if [ "$i" == "-h" ]
    then
      helpMode=0
      local last_idx=$((${#arguments[@]} - 1))
      local aliasName=${arguments[$last_idx]}
      helpAliases "${aliasName%.*}"
      printC $DIR/$aliasName gray
    fi;
  done
  return $helpMode
}
