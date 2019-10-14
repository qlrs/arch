#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1="\[\033[38;5;33m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;206m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

alias ls='ls --color=auto'
alias ll='ls -al'
alias ldate='ls -alt'
alias paci='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias memedown='sudo shutdown -h now'
alias pacr='sudo pacman -Rs'
alias h='cd /home/dan'
alias chox='chmod u+x'
alias i3lock='i3lock -c 000000'
alias p='python3'
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
#shows font list with easy to read name
alias fontmeme='fc-list | cut -f2 -d: | sort -u'
alias switch='sudo minicom ciscoSwitch'

#for pywal
(cat ~/.cache/wal/sequences &)




