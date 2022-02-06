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
export PASSWORD_STORE_X_SELECTION=primary

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
alias mv='mv -iv'
alias rm='rm -vI'
alias fd='fd --hidden'
alias editi3='nvim ~/.config/i3/config'
alias syncmusic='rsync -rtvP ~/music/ ~/storagedrive/music'
alias syncwebsite='rsync -rtvP ~/stuff/website/ ~/gitwebsite'
alias syncstuff='rsync -rtvP ~/stuff/ ~/storagedrive/stuff'
alias syncwindows='rsync -rtvP ~/stuff/ ~/windowssd/stuff'
alias fh='fzf --tac < ~/.zhistory'
alias ca='cd ~/archconfig'
alias cas='cd ~/archconfig/scripts'
alias ci='cd ~/.config/i3'
alias cis='cd ~/.config/i3/i3scripts'
alias cl='cd ~/linuxbook'
alias cc='cd ~/.config'
alias cs='cd ~/scripts'
alias cw='cd ~/stuff/website'
alias clc='cd ~/linuxbook/learnc'
alias ga='git add'
alias gp='git push && git push site && git push codeberg'
alias gc='git commit -m'
alias gs='git status'
alias xu='sudo xbps-install -Su'
alias xi='sudo xbps-install -S'
alias xr='sudo xbps-remove -R'
alias xq='sudo xbps-query -Rs'
alias paci='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias yayi='yay -S'
alias yayaur='yay -Sua'
alias pacr='sudo pacman -Rs'
alias yayr='yay -Rs'
alias i3lock='i3lock -c 000000'
alias p='perl'
alias sc='shellcheck -s sh'
alias vim='nvim '
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
alias fontmeme='fc-list | cut -f2 -d: | sort -u'
alias tvaudio='pacmd set-card-profile 0 output:hdmi-stereo-extra3'
alias sshserver='ssh -p 55443 root@rschrader.xyz'
alias updatesite='rsync -rtvP -e '\''ssh -p 55443'\'' ~/stuff/website/ root@rschrader.xyz:/var/www/wowee'
alias es='es.sh'
alias sxiv='devour sxiv'
alias mpv='devour mpv'
alias zathura='devour zathura'
alias vpnup='nmcli -a connection up'
alias stopwatch='termdown'
#for pywal
#(cat ~/.cache/wal/sequences &)

# For vim stuff
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

# Must be last
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

