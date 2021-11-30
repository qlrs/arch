#!/bin/bash
# Run script as root

#################
### Functions ###
#################

# Check if user has sudo installed
sudocheck () {
    pacman -Q | grep -q "sudo" || { echo "Please install sudo before running script... exiting" ; exit ;}
}

# Check if packages are installed, install them if not
installpackages() {
while IFS= read -r line; do
    pacman -Qqe | grep -q "$line" && echo "$line already installed" || echo "Installing $line..." ; pacman --noconfirm --needed -S "$line" &> /dev/null
done < "$1"
}

# Copy the config files from the git directory to their proper locations
placeconfigs() {
while IFS=, read -r file location; do
    sudo -u "$username" cp -r "/home/$username/archconfig/$file" "/home/$username/$location"
done < "$1"
}

# Create the user account, add them to the necessary groups, and
# set a password.
usernameandpassword() {
    echo "What do you want your username to be?" ; read -r username
    echo "What do you want your password to be?" ; read -r password
    useradd -m -G wheel -s /bin/bash "$username"
    echo "$username":"$password" | chpasswd
}

# Rename git repo directory
reporename() {
    cp -r "/root/arch" "/home/$username/archconfig"
    chown -R "$username":wheel /home/"$username"/archconfig
}

# Create a to-do list for things that I haven't done in this script
todolist() {
    cat <<EOF
Change mirrors to https (https://archlinux.org/mirrorlist/)
Set theme in lxappearance
Open nvim and run :PlugInstall
Add keys to git server
Enable fstrim.timer service (install util-linux if not available)
EOF
}

installparu() {
    echo "Installing Paru..."
    cd /home/"$username" || exit 1
    sudo -u "$username" git clone https://aur.archlinux.org/paru.git
    cd paru || exit 1
    sudo -u "$username" makepkg --noconfirm -si
}

installdmenu() {
    echo "Installing dmenu..."
    cd "/home/$username/programs" || exit 1
    sudo -u "$username" git clone https://github.com/mccreadyjonson/dmenu
    cd dmenu || exit 1
    sudo make
    sudo make install
}

# TODO
installvimplug() {
    sudo -u "$username" curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

#####################
### End functions ###
#####################

ping -c 1 9.9.9.9 &> /dev/null && echo "Success!" || echo "Please check your internet connection"

sudocheck

usernameandpassword || exit 1

# Seems necessary /shrug
[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers

# Adds user to sudoers file
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

sudo -u "$username" mkdir -p /home/"$username"/.config/{alacritty,dunst,i3,i3/i3scripts,mpd,ncmpcpp,nvim,picom,polybar,ranger,sxhkd,youtube-dl} /home/"$username"/{programs,linuxbook,stuff,stuff/website,stuff/walls,music,storagedrive,scripts,archwikidocs,gitwebsite}

installpackages packages.txt || exit 1

reporename || exit 1

# Generates skeleton config for ranger
sudo -u "$username" ranger --copy-config=all "$username"

# Put all the git repo files and folders in the right places
placeconfigs configlocations.csv || exit 1

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

# TODO
installvimplug

todolist > "/home/$username/todolist.txt"