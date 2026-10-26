#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
CONFIG="$HOME/.config"
MODE="${1:-}"
if [ "$MODE" != "dark" ] && [ "$MODE" != "light" ]; then
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
    MODE="dark"
  else
    MODE="light"
  fi
fi
cp "$CONFIG/sketchybar/colors-$MODE.sh" "$CONFIG/sketchybar/colors.sh"
"$CONFIG/borders/bordersrc"
sketchybar --reload
