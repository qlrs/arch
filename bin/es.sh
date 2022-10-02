#!/bin/sh

du -a "$HOME/bin" \
    "$HOME/.config/aerc" \
    "$HOME/.config/alacritty" \
    "$HOME/.config/calcurse" \
    "$HOME/.config/dunst" \
    "$HOME/.config/i3" \
    "$HOME/.config/lf" \
    "$HOME/.config/nvim/init.vim" \
    "$HOME/.config/nvim/templates" \
    "$HOME/.config/qutebrowser" \
    "$HOME/.config/ranger" \
    "$HOME/.config/sxhkd" | awk '{print $2}' | fzf | xargs -r "$EDITOR"
