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

function questionGet(){
  local q=$1
  local required=$2
  read -p "$q: " response
  echo $response
  if [ -n "$response" ]
  then
    echo $answer
    return 0
  else
    if [ -n "$required" ]
    then
      questionGet "$q" $required
    else
      return 1
    fi
  fi
}