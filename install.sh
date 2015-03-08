#!/usr/bin/env bash

source .git_aliases/_config.sh;
source .git_aliases/_printColor.sh;
source .git_aliases/_help.sh;
source .git_aliases/_question.sh;

if [ "$1" == "--list" ]
then
  .git_aliases/aliases.sh
  exit 0
fi

CONFIG_FILE=$HOME/.bash_profile
source $CONFIG_FILE

test -w $CONFIG_FILE &&
  cp $CONFIG_FILE $CONFIG_FILE.bak &&
  echo "Your original $CONFIG_FILE has been backed up to $CONFIG_FILE.bak" &&
  echo

installedAlias=()
dontInstalledAlias=()

# add alias to git config
function aliasInstall(){
  local gitExistsAliases=$(git config -l | grep -Pe "^alias\.")
  for alias in $gitExistsAliases
  do
    if [ -n "`echo $alias | grep -Poe "\.$curAliasName="`" ]
    then
      printC "\"$curAliasName\" already exists in git global config:" red
      echo $alias

      if ! question "Replace it?"
      then
        dontInstalledAlias+=($curAliasName)
        return
      fi

      break
    fi
  done

  copyAlias
  git config --global alias.$curAliasName "!$curHomeAliasPath"
  installedAlias+=($curAliasName)

  local bpExistsAliases=$(alias)
  while IFS=';' read -ra alias; do
    if [ -z "`echo $alias | grep -Poe "g$1="`" ]
    then
      echo "alias g$1='git $1'" >> $CONFIG_FILE
      break
    fi
  done <<< "$bpExistsAliases"
}

curAliasName=""
curAliasPath=""
curHomeAliasPath=""
function setAliasesPath(){
  curAliasName=$1
  curAliasPath="$aliasesFolder/$curAliasName.sh"
  curHomeAliasPath="$homeAliasesFolder/$curAliasName.sh"
}

# copy alias to home folder
function copyAlias(){
  cp $curAliasPath $curHomeAliasPath
  chmod u+x $curHomeAliasPath
}

# arguments:
# 1) array of modules (modules, silentAliases)
# 2) current file name
# check that array of modules contains current file name
function findModule(){
  local arguments=($@);
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

# create aliases folder
if [ ! -d $homeAliasesFolder ]
then
  mkdir $homeAliasesFolder;
fi

helpCopy

namedAliases=$@
for file in $aliasesFolder/*
do
  fileName=$(basename "$file")
  fileName="${fileName%.*}"
  setAliasesPath "$fileName"

  if findModule "${namedAliases[@]}" "$fileName"
  then
    echo $fileName
  elif [ ${#namedAliases[@]} -gt 0 ] && [ "${namedAliases[0]}" != "" ]
  then
    continue
  fi

  if findModule "${modules[@]}" "$fileName"
  then
    copyAlias
    continue
  fi

  if findModule "${beforePushModules[@]}" "$fileName"
  then
    copyAlias
    continue
  fi

  helpAliases "$fileName"

  if question "Install it?"
  then
    aliasInstall $fileName
  else
    dontInstalledAlias+=($curAliasName)
  fi

  echo
done

echo
echo "================"
if [ ${#installedAlias[@]} -ne 0 ]
then
  printC "Installed aliases:"
  printf '%s\n' "${installedAlias[@]}"
fi

echo
if [ ${#dontInstalledAlias[@]} -ne 0 ]
then
  printC "Don't installed aliases:" red
  printf '%s\n' "${dontInstalledAlias[@]}"
fi

echo
echo "Execute command:"
printC ". $CONFIG_FILE" cyan
echo "For update aliases"
echo
