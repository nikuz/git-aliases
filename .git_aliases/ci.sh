#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  if ! bash $DIR/_beforePush.sh
  then
    return
  fi

  local branch=$(git rev-parse --abbrev-ref HEAD)
  if ! bash $DIR/_clean.sh
  then
    git add .
    local isueNum=$(echo $branch | grep -Poe "[0-9]+$")

    local comment=$@
    if [ -z "$1" ]
    then
      comment="fix"
    fi
    comment+=" #$isueNum"

    echo $comment

    git commit -m "$comment"
  fi
  git push origin $branch:$branch
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
