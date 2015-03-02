#!/usr/bin/env bash

name="list"
description="list description"

if [ "$1" == "-h" ]
then
  echo $description
else

  if [ -z "$installEnvironment" ]
  then
    echo "list"
  fi

fi