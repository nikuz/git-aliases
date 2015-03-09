#!/usr/bin/env bash

source .git_aliases/_config.sh
source .git_aliases/_printColor.sh
source .git_aliases/_help.sh
source .git_aliases/_question.sh

if [ -z "$1" ]
then
  helpAliases "delete"
  exit 0
fi
if [ ! -d $homeAliasesFolder ]
then
  echo "No one alias installed. Run install.sh for install aliases."
  exit 0
fi

CONFIG_FILE=$HOME/.bash_profile
source $CONFIG_FILE

test -w $CONFIG_FILE &&
  cp $CONFIG_FILE $CONFIG_FILE.bak &&
  echo "Your original $CONFIG_FILE has been backed up to $CONFIG_FILE.bak" &&
  echo

deletedAlias=()
dontDeletedAlias=()

# add alias to git config
function aliasDelete(){
  local file=$1
  local curAliasName=$(basename "$file")
  curAliasName="${fileName%.*}"

  local gitExistsAliases=$(git config -l | grep -Pe "^alias\.")
  for alias in $gitExistsAliases
  do
    if [ -n "`echo $alias | grep -Poe "\.$curAliasName="`" ]
    then
      git config --global --unset alias.$curAliasName
      break
    fi
  done

  local bpExistsAliases=$(alias)
  while IFS=';' read -ra alias; do
    if [ -n "`echo $alias | grep -Poe "g$curAliasName="`" ]
    then
      sed -i "s/$alias//g" $CONFIG_FILE
      break
    fi
  done <<< "$bpExistsAliases"

  rm $file

  deletedAlias+=($curAliasName)
}

# arguments:
# 1) array of modules (modules, silentAliases)
# 2) current file name
# check that array of modules contains current file name
function findModule(){
  local arguments=($@)
  local last_idx=$((${#arguments[@]} - 1))
  local moduleName=${arguments[$last_idx]}
  unset arguments[$last_idx]

  for item in "${arguments[@]}"
  do
    if [ "$item" == "$moduleName" ]
    then
      return 0
    fi
  done
  return 1
}

namedAliases=$@
for file in $homeAliasesFolder/*
do
  fileName=$(basename "$file")
  fileName="${fileName%.*}"

  # if file is service module or README -> continue
  if findModule "${modules[@]}" "$fileName" ||
     findModule "${beforePushModules[@]}" "$fileName" ||
     [ -n "`echo $fileName | grep -Poe "^README"`" ]
  then
    continue
  fi

  if [ "$namedAliases" != "--all" ] && ! findModule "${namedAliases[@]}" "$fileName"
  then
    continue
  fi

  helpAliases "$fileName"
  if question "Delete it?"
  then
    aliasDelete $file
  else
    dontDeletedAlias+=($fileName)
  fi

  echo
done

if [ "$namedAliases" == "--all" ] && [ ${#dontDeletedAlias[@]} -eq 0 ]
then
  rm -rf $homeAliasesFolder
fi

echo
echo "================"
if [ ${#deletedAlias[@]} -ne 0 ]
then
  printC "Deleted aliases:"
  printf '%s\n' "${deletedAlias[@]}"
fi

echo
if [ ${#dontDeletedAlias[@]} -ne 0 ]
then
  printC "Don't deleted aliases:" red
  printf '%s\n' "${dontDeletedAlias[@]}"
fi
echo
