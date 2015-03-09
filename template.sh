#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  # write you code here
  echo "I'm new alias."
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
