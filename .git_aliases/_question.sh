#!/usr/bin/env bash

function question(){
  read -p "$1 " response
  for answer in y Y yes YES Yes Sure sure SURE OK ok Ok
  do
    if [ "$answer" == "$response" ]
    then
      return 0
    else
      return 1
    fi
  done
}