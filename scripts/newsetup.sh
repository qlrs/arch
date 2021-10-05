#!/bin/bash
# Run script as root

#################
### Functions ###
#################

# Check if user has sudo installed
sudocheck () {
    pacman -Q | grep -q "sudo" || echo "Please install sudo before running script... exiting" ; exit
}

# Check if packages are installed, install them if not
installpackages() {
while IFS= read -r line; do
    pacman -Qqe | grep -q "$line" && echo "$line already installed" || echo "Installing $line..." ; pacman --noconfirm --needed -S "$line" > /dev/null 2>&1
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
    echo "Creating a To-Do list in your home directory..."
    printf "Change mirrors to https (https://archlinux.org/mirrorlist/)\nSet theme in lxappearance\nAdd keys to git servers\nEnable fstrim.timer service (install util-linux if not available" | sudo -u "$username" tee "/home/$username/todolist.txt"
}

# Create mpd directory and necessary files
mpdstuff() {
    echo "" | sudo -u "$username" tee /home/"$username"/.config/mpd/mpd.db
    echo "" | sudo -u "$username" tee /home/"$username"/.config/mpd/mpd.log
    echo "" | sudo -u "$username" tee /home/"$username"/.config/mpd/mpd.pid
}

# Installs paru as an aur helper
installparu() {
    echo "Installing Paru..."
    cd /home/"$username" || exit 1
    sudo -u "$username" git clone https://aur.archlinux.org/paru.git
    cd paru || exit 1
    sudo -u "$username" makepkg --noconfirm -si
}

installvimplug() {
    sudo -u "$username" sh -c 'curl -fLo "/home/$username/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

#####################
### End functions ###
#####################

# Check for internet connection
ping -c 1 9.9.9.9 > /dev/null 2>&1 && echo "Success!" || echo "Please check your internet connection"

sudocheck

usernameandpassword || exit 1

# Seems necessary /shrug
[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers

# Adds user to sudoers file
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Big yikes I know
sudo -u "$username" mkdir -p "/home/$username/downloadmusic" "/home/$username/linuxbook" "/home/$username/memes" "/home/$username/memes/website" "/home/$username/music" "/home/$username/storagedrive" "/home/$username/scripts" "/home/$username/walls" "/home/$username/archwikidocs" "/home/$username/gitwebsite" "/home/$username/.newsboat" "/home/$username/.config/alacritty" "/home/$username/.config/dunst" "/home/$username/.config/i3" "/home/$username/.config/mpd" "/home/$username/.config/ncmpcpp" "/home/$username/.config/nvim" "/home/$username/.config/picom" "/home/$username/.config/polybar" "/home/$username/.config/ranger" "/home/$username/.config/sxhkd" "/home/$username/.config/youtube-dl"

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

mpdstuff

installvimplug

todolist
