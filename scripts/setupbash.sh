#!/bin/bash
# Run script as root
# newsetup.sh packages.txt 

# Check if user has sudo installed
sudocheck () {
    type sudo &> /dev/null || echo 'Please install sudo before running script' ; exit 1;
}

# Check if packages are installed, install them if not
installpackages() {
    while read -r; do
        pacman --noconfirm --needed -S "$REPLY" &> /dev/null
    done < "$1"
}

# Copy the config files from the git directory to their proper locations
placeconfigs() {
    while IFS=, read -r file location; do
        sudo -u "$username" cp -r "/home/$username/archconfig/$file" "/home/$username/$location"
    done < "$1"
}

getwallpapers() {
    url='https://rschrader.xyz/pics/'
    for i in $(curl -s https://rschrader.xyz/wallpapers.html | grep -o 'href=pics/[a-zA-Z0-9]\+\.\(jpg\|png\|jpeg\)'); do
    wget -nc "$url${i##*/}" -P "home/$username/walls"
    done
}

# Create the user account, add them to the necessary groups, and
# set a password.
usernameandpassword() {
    read -p 'What do you want your username to be?' -r username
    read -p 'What do you want your password to be?' -r password
    useradd -m -G wheel -s /bin/bash "$username"
    echo "$username":"$password" | chpasswd
}

# Rename git repo directory
reporename() {
    cp -r '/root/arch' "/home/$username/archconfig"
    chown -R "$username":wheel /home/"$username"/archconfig
}

# Create a to-do list for things that I haven't done in this script
todolist() {
    cat <<EOF
AUR packages: autotiling, devour, opustags
Change mirrors to https (https://archlinux.org/mirrorlist/)
Set theme in lxappearance

Open nvim and run :PlugInstall
Add keys to git server
Enable fstrim.timer service (install util-linux if not available)
EOF
}

installparu() {
    echo "Installing Paru..."
    cd /home/"$username/programs" || exit 2
    sudo -u "$username" git clone https://aur.archlinux.org/paru.git
    cd paru || exit 2
    sudo -u "$username" makepkg --noconfirm -si
}

installdmenu() {
    echo "Installing dmenu..."
    cd "/home/$username/programs" || exit 2
    sudo -u "$username" git clone https://github.com/mccreadyjonson/dmenu
    cd dmenu || exit 2
    sudo make
    sudo make install
}

# TODO
installvimplug() {
    sudo -u "$username" curl -fLo "$HOME"/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

ping -c 1 9.9.9.9 &> /dev/null || echo 'Please check your internet connection'

sudocheck

usernameandpassword || exit 1

# Seems necessary
[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers

# Adds user to sudoers file
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

sudo -u "$username" mkdir -p /home/"$username"/.config/{alacritty,dunst,i3,i3/i3scripts,mpd,ncmpcpp,nvim,picom,polybar,ranger,sxhkd,youtube-dl} /home/"$username"/{programs,linuxbook,stuff,stuff/website,stuff/walls,music,storagedrive,scripts,scripts/bashrewrites,archwikidocs,gitwebsite}

installpackages packages.txt

reporename

# Generates skeleton config for ranger
sudo -u "$username" ranger --copy-config=all "$username"

# Put all the git repo files and folders in the right places
placeconfigs configlocations.csv

# Change default shell to zsh
chsh -s /usr/bin/zsh "$username"

# Change sh to dash, bash updates will overwrite this though
sudo -u "$username" ln -sfT dash /usr/bin/sh

# Install paru as an aur helper
installparu

# Installs my build of dmenu which uses gruvbox dark colors by default
# and Liberation Mono font
installdmenu

# Create necessary files for mpd
sudo -u "$username" touch "/home/$username/.config/mpd/{mpd.db,mpd.log,mpd.pid}"

# Download wallpapers from my site
getwallpapers

# TODO
installvimplug

todolist > "/home/$username/todolist.txt"
