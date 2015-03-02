#!/usr/bin/env bash

name="ci"
description="ci description"

if [ "$1" == "-h" ]
then
  echo $description
else

  if [ -z "$installEnvironment" ]
  then
    echo "ci"
  fi

fi