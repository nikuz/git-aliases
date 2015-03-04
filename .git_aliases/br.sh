#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh;

function main(){
  if [ -n "`bash _clean.sh`" ]
  then
    printC "Please commit or stash your current branch changes" cyan
    git status
    return
  fi

  if [ -n "`echo \"$1\" | grep -Poe \"[0-9]+$\"`" ]
  then
    git checkout master;
    git co;
    wait ${pid};
    if [ -z "`bash _clean.sh`" ]
    then
      git branch $1;
      git checkout $1;
      git branch;
    else
      git status;
    fi;
  else
    getIsueNumber $1;
  fi;
}

getIsueNumber(){
  while true; do
    read -p "* Write isue number: " num
    case $num in
      [0-9]* )
        main "$1_$num";
        break;;

      * ) echo "Please write only numbers. It required field.";;
    esac
  done
}

for i in $@
do
  if [ "$i" == "-h" ]
  then
    helpMode=true;
  fi;
done

if [ -n "$helpMode" ]
then
  filename=`basename $0`
  helpAliases "${filename%.*}"
  printC $DIR/$name.sh gray
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi
