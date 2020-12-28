# If not running interactively, don't do anything
#[[ $- != *i* ]] && return
autoload -U colors && colors
PS1="%B[%F{yellow}%1~%f]%b $ "

HISTSIZE=10000
SAVEHIST=10000
export HISTFILE=~/.zhistory

setopt autocd
autoload -U compinit
autoload -Uz url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -ahl'
alias ldate='ls -ahlt'
alias grep='grep --color=auto'
alias cp='cp -iv'
alias mv='mv -v'
alias rm='rm -vI'
alias fd='fd --hidden'
alias rs='rsync -urv'
alias ca='cd ~/archconfig'
alias ci='cd ~/.config/i3'
alias cis='cd ~/.config/i3/scripts'
alias cl='cd ~/linuxbook'
alias cc='cd ~/.config'
alias cs='cd ~/scripts'
alias cw='cd ~/memes/website'
alias paci='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias yayi='yay -S'
alias yayaur='yay -Sua'
alias pacr='sudo pacman -Rs'
alias yayr='yay -Rs'
alias i3lock='i3lock -c 000000'
alias p='python3'
alias vim='nvim '
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
#shows font list with easy to read name
alias fontmeme='fc-list | cut -f2 -d: | sort -u'
alias wttr='curl -s https://wttr.in/29575\?uT'
alias switch='sudo minicom ciscoSwitch'
alias tvaudio='pacmd set-card-profile 0 output:hdmi-stereo-extra3'
#fixes the fucking time
#but you need to adjust to the correct time
alias fixfuckingtime='timedatectl set-time "2020-05-24 17:50:00"'
alias tuir='tuir --enable-media'
alias clearlock='xmodmap -e "clear lock"'
alias sshserver='ssh -p 55443 root@rschrader.xyz'
alias updatesite='rsync -urv -e '\''ssh -p 55443'\'' ~/memes/website/* root@rschrader.xyz:/var/www/wowee/'
#for pywal
#(cat ~/.cache/wal/sequences &)

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
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

