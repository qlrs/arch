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
alias vn="$EDITOR ~/NOTES.md"
alias bc='bc -l'
alias editi3='nvim ~/.config/i3/config'
alias syncmusic='rsync -rtvP ~/music/ ~/storagedrive/music'
alias syncwebsite='rsync -rtvP ~/stuff/website/ ~/gitwebsite'
alias syncstuff='rsync -rtvP ~/stuff/ ~/storagedrive/stuff'
alias syncwindows='rsync -rtvP ~/stuff/ ~/windowssd/stuff'
alias syncwindowsmusic='rsync -rtvP ~/music/ ~/windowssd/music'
alias fh='history | cut -d " " -f4- | uniq | fzf | xclip -i -selection clipboard -r'
alias ca='cd ~/archconfig'
alias cas='cd ~/archconfig/bin'
alias cis='cd ~/.config/i3/i3scripts'
alias cl='cd ~/linuxbook'
alias ccg='cd ~/.config'
alias cs='cd ~/bin'
alias cw='cd ~/stuff/website'
alias cpys='cd ~/linuxbook/python_stuff'
alias cg='cd ~/linuxbook/go_stuff'
alias cb='cd ~/stuff/books'
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
alias sysr='sudo systemctl restart'
alias i3lock='i3lock -c 000000'
alias p='python'
alias sc='shellcheck -s sh'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
alias fontmeme='fc-list | cut -f2 -d: | sort -u'
alias tvaudio='pacmd set-card-profile 0 output:hdmi-stereo-extra3'
alias sshserver='ssh -p 55443 root@rschrader.xyz'
alias updatesite='rsync -rtvP -e '\''ssh -p 55443'\'' --exclude=.git ~/stuff/website/ root@rschrader.xyz:/var/www/wowee'
alias es='es.sh'
alias sxiv='devour sxiv'
alias mpv='devour mpv'
alias zathura='devour zathura'
alias vpnup='nmcli -a connection up'
alias g='glow -p'
alias webcam='mplayer tv://'

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
    local hostname=$(nmcli general hostname)
    local vpnserver='ashburn.protonvpn'
    if [[ "$hostname" == "arch" ]]; then
        local output=$(nmcli connection show --active $vpnserver)
    else
        local output=$(nmcli connection show --active "atlanta_protonvpn")
    fi

    if [[ "$output" = "" ]] && [[ "$hostname" == "arch" ]]; then
        nmcli -a connection up "$vpnserver"
    fi

    if [[ "$output" = "" ]] && [[ "$hostname" == "archMachine" ]]; then
        nmcli -a connection up "atlanta_protonvpn"
    fi
}
vpncheck


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
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
