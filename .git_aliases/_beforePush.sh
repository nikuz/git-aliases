#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_config.sh
source $DIR/_printMultiline.sh

declare response=0
declare request

for file in $homeAliasesFolder/*
do
  fileName=$(basename "$file")
  if [ -n "`echo $fileName | grep -Poe "^__"`" ]
  then
    request=$(bash $file)
    if [ -n "`echo $request`" ]
    then
      response=1
      printM "$request"
      break
    fi
  fi
done

exit $response