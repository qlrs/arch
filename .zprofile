export PATH="$PATH:$HOME/bin:$HOME/linuxbook:$HOME/linuxbook/bookstuff:$HOME/.config/i3/i3scripts:$HOME/programs/dmenu:$HOME/bin/bashrewrites"
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="alacritty"

# swap caps and escape in tty
sudo loadkeys "$HOME/.local/share/keymaps"

# auto start x
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    startx
fi
