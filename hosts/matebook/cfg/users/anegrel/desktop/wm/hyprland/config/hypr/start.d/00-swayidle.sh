#!/usr/bin/env bash

nohup swayidle -w \
  timeout 600 'hyprctl dispatch dpms off' \
  resume 'hyprctl dispatch dpms on' \
  before-sleep 'swaylock' &> /dev/null &

