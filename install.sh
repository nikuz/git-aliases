#!/usr/bin/env bash

source .git_aliases/_config.sh;
source .git_aliases/_printColor.sh;
source .git_aliases/_help.sh;
installMode=true

installedAlias=()
dontInstalledAlias=()

# add alias to git config
function aliasInstall(){
  local gitExistsAliases=$(git config -l | grep -Pe "^alias\.")
  for alias in $gitExistsAliases
  do
    if [ -n "`echo $alias | grep -Poe "\.$curAliasName="`" ]
    then
      printC "Can't install alias '$curAliasName', because it already exists in git global config:" red
      echo $alias
      while true; do
        read -p "Replace it? y/n " yn
        case $yn in
          ""|[yY]* )
            break;;

          [nN]* )
            dontInstalledAlias+=($curAliasName)
            return;;

          * ) echo "Please write answer.";;
        esac
      done
      break
    fi
  done

  copyAlias
  git config --global alias.$curAliasName "!$curHomeAliasPath"
  installedAlias+=($curAliasName)
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

for file in $aliasesFolder/*
do
  fileName=$(basename "$file")
  fileName="${fileName%.*}"
  setAliasesPath "$fileName"

  if findModule "${modules[@]}" "$fileName"
  then
    copyAlias
    continue
  fi

  if findModule "${silentAliases[@]}" "$fileName"
  then
    aliasInstall
    continue
  fi

  if findModule "${beforePushModules[@]}" "$fileName"
  then
    copyAlias
    continue
  fi

  helpAliases "$fileName"

  while true; do
    read -p "Install it? y/n " yn
    case $yn in
      ""|[yY]* )
        aliasInstall
        wait $pid
        break;;

      [nN]* )
        dontInstalledAlias+=($curAliasName)
        break;;

      * ) echo "Please write answer.";;
    esac
  done
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