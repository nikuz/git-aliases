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

  if ! $DIR/_clean.sh
  then
    printC "Please commit or stash your current branch changes" cyan
    git status
    return
  fi

  if [ -z "`echo \"$1\" | grep -Poe \"[0-9]+$\"`" ]
  then
    getIssueNumber $1
  else
    local branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" != "master" ]
    then
      git checkout master
    fi

    git pull origin master
    if ! $DIR/_clean.sh
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
