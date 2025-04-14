#!/usr/bin/env bash

git() {
  local updated=()

  for i in $(ls);do
    git pull | grep -v "Already up to date."
    if [ $? == 1] then
      $updated+="$i"
    fi
  done

  echo ${updated[@]}
}

