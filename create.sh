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

function configChange(){
  local modulesName=$1
  local newModule=$2
  sed -ri "s/$modulesName=\(([^)]+)\)/$modulesName=(\1 \"$newModule\")/" .git_aliases/_config.sh
}

nameGet name
descr=$(questionGet "Short description" "True")
template="template.sh"

if question "It's background module?"
then
  name="_$name"
  configChange "modules" "$name"
  template="template_module.sh"
else
  if question "It's \"before push\" module?"
  then
    name="__$name"
    configChange "beforePushModules" "$name"
    template="template_module.sh"
  fi
fi

#Add README description
echo "
- - -
$name
--

$descr
" >> README.md

aliasPath=".git_aliases/$name.sh"
cp $template $aliasPath
echo "New alias placed here:"
printC $aliasPath
echo
if question "Do you want edit it now?"
then
  vi $aliasPath
  wait ${pid}
  if question "Do you want install it now?"
  then
    . install.sh -q $name
  fi
fi
