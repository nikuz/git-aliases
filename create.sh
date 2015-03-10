#!/usr/bin/env bash

source .git_aliases/_config.sh
source .git_aliases/_printColor.sh
source .git_aliases/_help.sh
source .git_aliases/_question.sh

function nameGet(){
  local result=$1
  local pattern="^[a-zA-Z0-9]+$"
  local qName=$(questionGet "Alias name" "True")
  if [ -n "`echo $qName | grep -Poe "$pattern"`" ]
  then
    eval "$result=\"$qName\""
  else
    printC "Wrong name. Try again." red
    nameGet $result
  fi
}

function nameCheckExists(){
  local name="$1.sh"
  if [ -e .git_aliases/$name ]
  then
    return 0
  else
    return 1
  fi
}

function configChange(){
  local modulesName=$1
  local newModule=$2
  sed -ri "s/$modulesName=\(([^)]+)\)/$modulesName=(\1 \"$newModule\")/" .git_aliases/_config.sh
}
function create(){
  local name=""
  nameGet name
  local descr=$(questionGet "Short description" "True")
  local template="template.sh"

  local moduleType
  if question "It's background module?"
  then
    name="_$name"
    moduleType="modules"
    template="template_module.sh"
  else
    if question "It's \"before push\" module?"
    then
      name="__$name"
      moduleType="beforePushModules"
      template="template_module.sh"
    fi
  fi

  if nameCheckExists $name
  then
    printC "Alias \"$name\" is already exist. Try other name." red
    create
    return 1
  fi

  if [ -n "$moduleType" ]
  then
    configChange "$moduleType" "$name"
  fi

  #Add README description
  echo "
- - -
$name
--

$descr
" >> README.md

  local aliasPath=".git_aliases/$name.sh"
  cp $template $aliasPath
  echo "New alias placed here:"
  printC $aliasPath
  echo
  if question "Do you want edit it now?"
  then
    vi $aliasPath
    wait ${pid}
  fi
  if question "Do you want install it now?"
  then
    . install.sh -q $name
  fi
}

create
