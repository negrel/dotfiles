#!/usr/bin/env bash

# Rename workspaces
hyprctl dispatch renameworkspace "1 browser" &
hyprctl dispatch renameworkspace "2 x" &
hyprctl dispatch renameworkspace "3 c" &
wait

# Setup applications
hyprctl dispatch exec "[workspace name:browser] firefox"
