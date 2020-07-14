#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1="[\[$(tput sgr0)\]\[\033[38;5;13m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]] \\$ \[$(tput sgr0)\]"

#set -o vi

alias ls='ls --color=auto'
alias ll='ls -ahl'
alias ldate='ls -ahlt'
alias grep='grep --color=always'
alias cp='cp -v'
alias paci='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias memedown='sudo shutdown -h now'
alias pacr='sudo pacman -Rs'
alias h='cd /home/dan'
alias chox='chmod u+x'
alias i3lock='i3lock -c 000000'
alias p='python3'
alias vim='nvim '
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
#shows font list with easy to read name
alias fontmeme='fc-list | cut -f2 -d: | sort -u'
alias switch='sudo minicom ciscoSwitch'
#fixes the fucking time
#but you need to adjust to the correct time
alias fixfuckingtime='timedatectl set-time "2020-05-24 17:50:00"'
alias tuir='tuir --enable-media'
alias sshserver='ssh root@rschrader.xyz'
#for pywal
(cat ~/.cache/wal/sequences &)




