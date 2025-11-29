#!/bin/bash
allservs=$(ls "$HOME/.service")
for service in $allservs; do
  mkdir "$service"
  cd "$service" || return
  mkdir -p log/main
  cp "$HOME/.service/$service/run" ./run
  cp "$HOME/.service/$service/log/run" ./log/run
  cd ..
done
