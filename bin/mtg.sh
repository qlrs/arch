#!/bin/sh

selection="$(du -a "$HOME"/scripts/ "$HOME"/.config/i3 | awk '{print $2}' | fzf)"
target="$(du --exclude=.git "$HOME"/archconfig/ | awk '{print $2}' | fzf)/"
cp -iv "$selection" "$target"
