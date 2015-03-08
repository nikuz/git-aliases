#!/usr/bin/env bash

if [ -n "`git status | grep -Poe "working directory clean"`" ]
then
  exit 0
else
  exit 1
fi