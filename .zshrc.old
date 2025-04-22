autoload -U colors && colors
PS1="%B[%F{yellow}%1~%f]%b $ "
PS2='%_> '
echo -ne '\e[5 q'
source <(fzf --zsh)
bindkey '^R' fzf-history-widget

HISTSIZE=10000
SAVEHIST=10000
export HISTFILE=~/.zhistory

setopt auto_cd
setopt append_history
setopt share_history
setopt extended_history
setopt histignorespace
# Display PID when suspending processes
setopt longlistjobs
# report the status of backgrounds jobs immediately
setopt notify
# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob
autoload -U compinit
compinit
# autoload -Uz url-quote-magic
# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic
# zle -N self-insert url-quote-magic
zstyle ':completion:*' menu select
# zmodload zsh/complist
# _comp_options+=(globdots)	
# bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1
export PASSWORD_STORE_X_SELECTION=primary
bindkey -e

#Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history

alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -ahl'
alias ldate='ls -ahlt'
alias grep='grep --color=auto'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias bc='bc -l'
alias ip='ip -c=auto'
alias editi3='nvim ~/.config/i3/config'
alias syncmusic='rsync -rtvP ~/music/ ~/storagedrive/music'
alias syncwebsite='rsync -rtvP ~/stuff/website/ ~/gitwebsite'
alias syncstuff='rsync -rtvP ~/stuff/ ~/storagedrive/stuff'
alias syncwindows='rsync -rtvP ~/stuff/ ~/windowssd/stuff'
alias syncwindowsmusic='rsync -rtvP ~/music/ ~/windowssd/music'
alias syncnotes='rsync -av --progress ~/stuff/sync/roam_notes/ ~/gitnotes/roam_notes/; rsync -av --progress ~/stuff/sync/cybersecurity/notes/ ~/gitnotes/notes/'
alias ca='cd ~/archconfig'
alias cis='cd ~/.config/i3/i3scripts'
alias cl='cd ~/linuxbook'
alias ga='git add'
alias gp='git push && git push site && git push codeberg'
alias gc='git commit -m'
alias gs='git status'
alias paci='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias pacr='sudo pacman -Rs'
alias sysr='sudo systemctl restart'
alias i3lock='i3lock -c 000000'
alias sc='shellcheck -s sh'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
alias fontmeme='fc-list | cut -f2 -d: | sort -u'
alias sshserver='ssh -p 55443 root@rschrader.xyz'
alias updatesite='rsync -rtvP -e '\''ssh -p 55443'\'' --exclude=.git ~/stuff/website/ root@rschrader.xyz:/var/www/wowee'
alias vpnup='nmcli -a connection up'
alias webcam='mplayer tv://'
alias fixssh='sudo ip li set mtu 1200 dev'

eval $(keychain --eval --quiet ~/.ssh/id_rsa)

vterm_printf() {
    printf "\e]%s\e\\" "$1"
}

vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}

# open file in emacs from vterm
eopen() {
    vterm_cmd find-file "$(realpath "${@:-.}")"
}

finder() {
  dirssync=$(find "$HOME"/stuff/sync -type d)
  filessync=$(find "$HOME"/stuff/sync -type f)
  dirsconfig=$(find "$HOME"/.config -type d)
  filesconfig=$(find "$HOME"/.config -type f)
  binfiles=$(find "$HOME"/bin -type f)
  homefiles=$(find "$HOME" -maxdepth 1 -type f)

  selection=$(printf "%s\n%s\n%s\n%s\n%s\n%s" \
    "$dirssync" "$filessync" \
    "$dirsconfig" "$filesconfig" \
    "$binfiles" "$homefiles"\
    | fzf)

  [[ -z $selection ]] && exit
  echo "$selection" | xclip -i -selection cipboard -r

  if [[ -d $selection ]]; then
    cd "$selection" || exit
  else
    if [[ $1 == "n" ]];then
      "$EDITOR" "$selection"
    else
      bat "$selection"
    fi
  fi
}

# Make sure a vpn is active
vpncheck() {
    output=$(nmcli | grep "connected (externally) to tun0")
    if [[ "$output" = "" ]]; then
        nmcli -a connection up "03222025atlanta"
    fi
}
vpncheck


# For vim stuff
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
#  echo -ne '\e[5 q' # Use beam shape cursor on startup.
#  preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Must be last
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
