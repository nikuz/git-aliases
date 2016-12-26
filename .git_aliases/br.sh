#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  if [ -z "$1" ]
  then
    printC "Branch name required" cyan
    return
  fi

  if [ ! $DIR/_clean.sh ]
  then
    printC "Please commit or stash your current branch changes" cyan
    git status
    return
  fi

  local parentBranch
  if [ -z "$2" ]
  then
    parentBranch="master"
  elif [ -z "`git branch | grep -o "$2"`" ]
  then
    printC "'$2' branch doesn't exist" red
    return
  else
    parentBranch="$2"
  fi


  if [ -z "`echo $1 | grep -o "[0-9]\+"`" ]
  then
    getIssueNumber $1
  else
    local branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" != $parentBranch ]
    then
      git checkout $parentBranch
    fi

    git pull origin $parentBranch
    if [ ! $DIR/_clean.sh ]
    then
      git status
      return
    fi

    git branch $1
    git checkout $1
    git branch
  fi
}

getIssueNumber(){
  while true
  do
    read -p "* Write isue number: " num
    case $num in
      [0-9]* )
        main "$1_$num"
        break;;

      * ) echo "Please write only numbers. It required field.";;
    esac
  done
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
