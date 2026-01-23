#!/bin/bash
wallust run "$1" 
killall -SIGUSR2 waybar
