#!/bin/sh

du -a "$HOME/scripts" "$HOME/.config" "$HOME/linuxbook" | awk '{print $2}' | fzf | xargs -r "$EDITOR"

