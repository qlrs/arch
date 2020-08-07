# If not running interactively, don't do anything
#[[ $- != *i* ]] && return
PS1="[%B%~%b] $ "

HISTSIZE=10000
SAVEHIST=10000
export HISTFILE=~/.zhistory

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

alias ls='ls --color=auto'
alias ll='ls -ahl'
alias ldate='ls -ahlt'
alias grep='grep --color=always'
alias cp='cp -v'
alias fd='fd --hidden'
alias wttr='curl wttr.in/"Myrtle Beach"?u'
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

#for vim stuf
####
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
####

#must be last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

