#!/usr/bin/env bash

if [ -z "$installMode" ]
then
  if [ -n "`git status | grep -Poe "working directory clean"`" ]
  then
      response=0
  else
      git status
      response=1
  fi;

  exit $response
fi