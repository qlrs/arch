#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1="\[\033[38;5;6m\]\u@\h:\[$(tput sgr0)\]\[\033[38;5;207m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;243m\]\\$\[$(tput sgr0)\]"

alias ls='ls --color=auto'
alias ll='ls -al'
alias ldate='ls -alt'
alias paci='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias memedown='sudo shutdown -h now'
alias pacr='sudo pacman -Rs'
alias h='cd /home/dan'
alias i3lock='i3lock -c 000000'
alias p='python3'
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
#shows font list with easy to read name
alias fontmeme='fc-list | cut -f2 -d: | sort -u'





