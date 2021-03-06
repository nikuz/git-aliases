#!/usr/bin/env bash

source .git_aliases/_config.sh
source .git_aliases/_printColor.sh
source .git_aliases/_help.sh
source .git_aliases/_question.sh

if [ "$1" == "-list" ]
then
  .git_aliases/aliases.sh
  exit 0
fi

if [ "$1" == "-q" ]
then
  quietMode="True"
fi

CONFIG_FILE=$HOME/.bash_profile
source $CONFIG_FILE

test -w $CONFIG_FILE &&
  cp $CONFIG_FILE $CONFIG_FILE.bak &&
  echo "Your original $CONFIG_FILE has been backed up to $CONFIG_FILE.bak" &&
  echo

installedAlias=()
installedModules=()
dontInstalledAlias=()

# add alias to git config
function aliasInstall(){
  local file=$1
  local curAliasName=$(basename "$file")
  curAliasName="${fileName%.*}"

  local gitExistsAliases=$(git config -l | grep -e "^alias\.")
  for alias in $gitExistsAliases
  do
    if [ -n "`echo $alias | grep -o "\.$curAliasName="`" ]
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

  copyAlias $file
  local curHomeAliasPath="$homeAliasesFolder/$curAliasName.sh"
  git config --global alias.$curAliasName "!$curHomeAliasPath"
  installedAlias+=($curAliasName)

  local bpExistsAliases=$(alias)
  local bpAliasMatch
  while IFS=';' read -ra alias; do
    if [ -n "`echo $alias | grep -o "g$curAliasName="`" ]
    then
      bpAliasMatch=true
      break
    fi
  done <<< "$bpExistsAliases"

  if [ -z "$bpAliasMatch" ]
  then
    echo "alias g$curAliasName='git $curAliasName'" >> $CONFIG_FILE
  fi
}

# copy alias to home folder
function copyAlias(){
  local file=$1
  local curAliasName=$(basename "$file")
  local curHomeAliasPath="$homeAliasesFolder/$curAliasName"

  cp $file $curHomeAliasPath
  chmod u+x $curHomeAliasPath
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
# create aliases folder if not exists
if [ ! -d $homeAliasesFolder ]
then
  mkdir $homeAliasesFolder
fi


# copy modules
for item in "${modules[@]}" "${beforePushModules[@]}"
do
  declare homeAlias="$homeAliasesFolder/$item.sh"
  if [ ! -e $homeAlias ]
  then
    copyAlias "$aliasesFolder/$item.sh"
    installedModules+=($item)
  fi
done


helpCopy

namedAliases=($@)
if [ -z $quietMode ]
then
  namedIndex=0
else
  namedIndex=1
fi
for file in $aliasesFolder/*
do
  fileName=$(basename "$file")
  fileName="${fileName%.*}"
  curHomeAliasPath="$homeAliasesFolder/$fileName.sh"

  if [ ${#namedAliases[@]} -gt $namedIndex ] && [ "${namedAliases[0]}" != "" ] && ! findModule "${namedAliases[@]}" "$fileName"
  then
    continue
  fi

  if [ ! -e $curHomeAliasPath ]
  then
    if [ -z $quietMode ]
    then
      helpAliases "$fileName"
      if question "Install it?"
      then
        aliasInstall $file
      else
        dontInstalledAlias+=($fileName)
      fi
      echo
    else
      aliasInstall $file
    fi
  fi
done

echo
echo "================"
if [ ${#installedAlias[@]} -ne 0 ]
then
  printC "Installed aliases:"
  printf '%s\n' "${installedAlias[@]}"
  echo
fi

if [ ${#installedModules[@]} -ne 0 ]
then
  printC "Installed modules:"
  printf '%s\n' "${installedModules[@]}"
  echo
fi

if [ ${#dontInstalledAlias[@]} -ne 0 ]
then
  printC "Don't installed aliases:" red
  printf '%s\n' "${dontInstalledAlias[@]}"
  echo
fi

echo
echo "Execute command:"
printC ". $CONFIG_FILE" cyan
echo "For update aliases"
echo
