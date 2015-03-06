#!/usr/bin/env bash

function printM(){
  while IFS=';' read -ra lines; do
    for line in "${lines[@]}"; do
      echo $line
    done
  done <<< "$@"
}