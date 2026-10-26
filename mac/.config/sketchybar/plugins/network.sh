#!/bin/sh
IF=$(route get default 2>/dev/null | awk '/interface:/{print $2}')
if [ -z "$IF" ]; then
  sketchybar --set "$NAME" label="NET OFF"
else
  sketchybar --set "$NAME" label="NET $(ipconfig getifaddr "$IF")"
fi
