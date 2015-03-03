#!/usr/bin/env bash

# arguments:
# 1) string
# 2) color
printC(){
  local -A colors=(
    ["green"]="\E[32;40m"
    ["cyan"]="\e[0;36m"
    ["red"]="\e[31m"
    ["gray"]="\e[90m"
    ["nc"]="\e[0m" # No Color
  )

  local colorIndex="green"
  if [ -n "$2" ]
  then
    colorIndex=$2
  fi;
  local color=${colors[$colorIndex]}
  local NC=${colors["nc"]}

  echo -e "$color$1$NC"
}
