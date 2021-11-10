#!/bin/bash
du -a "$HOME/scripts" "$HOME/.config" | awk '{print $2}' | fzf | xargs "$EDITOR"
