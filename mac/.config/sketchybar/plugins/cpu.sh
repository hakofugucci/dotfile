#!/bin/sh
CORES=$(sysctl -n hw.logicalcpu)
CPU=$(ps -A -o %cpu | awk -v c="$CORES" '{s+=$1} END {printf "%.0f", s/c}')
sketchybar --set "$NAME" label="CPU ${CPU}%"
