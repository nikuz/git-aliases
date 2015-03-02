#!/usr/bin/env bash

name="co"
description="co description"

if [ "$1" == "-h" ]
then
  echo $description
else

  if [ -z "$installEnvironment" ]
  then
    echo "co"
  fi

fi
