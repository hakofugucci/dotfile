#!/bin/sh
FREE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print $5}' | tr -d '%')
[ -z "$FREE" ] && exit 0
sketchybar --set "$NAME" label="RAM $((100 - FREE))%"
