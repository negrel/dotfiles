#!/usr/bin/env bash

ollama serve &> /dev/null &
PID=$!

: "${MODEL:="mistral"}"

ollama run "$MODEL" "$@"

kill "$PID"
