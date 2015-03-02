#!/usr/bin/env bash

installEnvironment=true
aliasesFolder=".git_aliases"

# copy alias to home folder
# add alias to git config
function aliasInstall(){
  # create aliases folder
  local homeAliasesFolder="$HOME/$aliasesFolder"
  if [ ! -d $homeAliasesFolder ]
  then
    mkdir $homeAliasesFolder;
  fi

  local homeAlias="$homeAliasesFolder/$name.sh"
  local alias="$aliasesFolder/$name.sh"

  if [ ! -e $homeAlias ]
  then
    cp $alias $homeAlias
    chmod u+x $homeAlias
    git config --global alias.$name "!$homeAlias"
  fi
}

# check to exists files and folders
function checkExists(){
  local path=$1;
  echo $path;
}

for file in $aliasesFolder/*
do
    source $file;
    echo $name;
    echo $description;

    while true; do
      read -p "Install it? " yn
      case $yn in
        [yY]* ) aliasInstall; wait $pid; break;;
        [nN]* ) break;;
        * ) echo "Please write answer.";;
      esac
    done
done