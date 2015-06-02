#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

#function main(){
#  git status | grep -E "\/" | sed 's/#\s//' | xargs rm -rf
#}

if ! helpMode $@ `basename $0`
then
  main $@
fi
