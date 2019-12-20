#!/bin/bash

isMounted    () { findmnt -rno SOURCE,TARGET "$1" >/dev/null;} #path or device

function mountLMHOMEShare {
  echo "Will Require Sudo Privileges"

  sudo mount -t nfs 206.87.86.221:/home/lmayall/storage /home/lmayall/Network/lmhome

  echo ":)"
}

validInput=false
# Actions: 1 mount, 2, unmount, 0 check mount
# shellcheck disable=SC2034
declare -A mounts=( [1]="LMHOME Share" [2]="Test" )
# shellcheck disable=SC2034
declare -A mountPoints( ["${mounts[1]})"]="/home/lmayall/Network/lmhome" ["${mounts[2]})"]="Test!" )
declare -A mountDevices( ["${mounts[1]})"]="206.87.86.221:/home/lmayall/storage" ["${mounts[2]})"]="Test!" )

echo 1: LMHOME Share

read -r selection action

for mount in "${!mounts[@]}"
do
  if [ "$selection" == "$mount" ]; then
    echo "${mounts[$mount]}"
    validInput=true
fi
done

if [ $validInput == true ]; then
  case $selection in
  1)
    mountLMHOMEShare
  ;;
  esac

else
  echo "Invalid Input :("
fi




