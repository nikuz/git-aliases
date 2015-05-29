#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_config.sh
source $DIR/_printColor.sh

# arguments:
# 1) alias name
function helpAliases(){
  local aliasName=$1
  local helpFile
  if [ -d $homeAliasesFolder ]
  then
    helpFile="$homeAliasesFolder/$readme"
  else
    helpFile="$PWD/$readme"
  fi
  local isStarted
  local matchedLines=0

  shopt -s nocasematch
  cat $helpFile | while read line
  do
    if [[ $line == "### $aliasName" ]]
    then
      printC $(echo $line | sed "s/\#//g")
      isStarted=true
    fi

    if [ $isStarted ] && [ $matchedLines -gt 1 ] && [[ $line == "###"* ]]
    then
      break
    fi

    if [ $isStarted ] && [ $matchedLines -gt 1 ] && [ -n "$line" ]
    then
      echo $line | sed -e "s/<br>//g"
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
  local arguments=($@)
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
    fi
  done
  return $helpMode
}
