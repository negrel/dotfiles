#!/usr/bin/env bash

schema=org.gnome.desktop.interface
exec hyprctl setcursor $(gsettings get $schema cursor-theme | tr -d "'") $(gsettings get $schema cursor-size)

