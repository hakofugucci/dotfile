#!/bin/sh
# 外付けありなら 1〜5 を外付け(1)、6〜7 をMac本体(2)へ。外付けなしなら何もしない。
# （外付けなしのときは、macOSが全Spaceを自動でMac本体にまとめる）

sleep 2

# 外付けが無ければ終了
[ "$(yabai -m query --displays | jq length)" -lt 2 ] && exit 0

# Space 6, 7 が display 2 以外にあれば、display 2 へ移す
for s in 6 7; do
  d=$(yabai -m query --spaces --space $s 2>/dev/null | jq '.display')
  [ -n "$d" ] && [ "$d" != "2" ] && yabai -m space $s --display 2
done

sketchybar --reload
