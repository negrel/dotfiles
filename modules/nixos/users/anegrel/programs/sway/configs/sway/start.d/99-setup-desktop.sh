#!/usr/bin/env bash

set -eo pipefail

outputs=$(swaymsg -t get_outputs | jq '. | length')

if [ "$outputs" -gt "1" ]; then
	swaymsg workspace number 9
	swaymsg workspace number 2
	swaymsg workspace number 1
fi

# Firefox on workspace 1
swaymsg exec firefox

