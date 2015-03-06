#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printMultiline.sh

declare gruntFile=$PWD/Gruntfile.js
if [ ! -e $gruntFile ]
then
  exit 0
fi

declare -a taskList=()
declare task
while read line
do
  task=$(echo $line | grep -Poe "(?<=grunt.registerTask\(')[^']+")
  if [ -n "$task" ]
  then
    taskList+=($task)
  fi
done < ${gruntFile}

declare success="Done, without errors."
for task in "${taskList[@]}"
do
  taskExec=$(grunt $task)
  if [ -z "`echo $taskExec | grep -Poe "$success"`" ]
  then
    printM "$taskExec"
    exit 1
  fi
done

exit 0
