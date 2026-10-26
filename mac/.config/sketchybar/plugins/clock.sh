#!/bin/sh
W=$(LC_TIME=ja_JP.UTF-8 date '+%a')
sketchybar --set "$NAME" label="$(date '+%m/%d') $W $(date '+%H:%M:%S')"
