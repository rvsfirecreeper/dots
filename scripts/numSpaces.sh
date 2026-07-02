#!/bin/bash
niri msg workspaces | tail -n 1 | sed "s/[^0-9]//g"
