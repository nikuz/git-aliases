#!/usr/bin/env bash

# arguments:
# 1) string
# 2) color
printC(){
  local -a colors=(
    "\E[32;40m%s\e[0m\n" # green
    "\e[0;36m%s\e[0m\n" # cyan
    "\e[31m%s\e[0m\n" # red
    "\e[90m%s\e[0m\n" # gray
  )

  local colorIndex
  case "$2" in
  "cyan")
    colorIndex=1
  ;;
  "red")
    colorIndex=2
  ;;
  "gray")
    colorIndex=3
  ;;
  *)
    colorIndex=0
  ;;
  esac
  printf ${colors[$colorIndex]} "$1"
}
