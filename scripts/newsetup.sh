#!/bin/bash
# Run script as root
# TODO
# MAJOR fix mkdir section, many need a .config/ before the name
# Add paru installation


# Check if packages are installed, install them if not
installpackages() {
while IFS= read -r line; do
    [ "$(pacman -Qqe | grep "$line")" ] && echo "$line already installed" || sudo -u "$username" pacman --noconfirm --needed -S "$line"
done < "$1"
}


# Copy the config files from the git directory to their proper locations
placeconfigs() {
while IFS=, read -r file location; do
    cp -r "/home/$username/archconfig/$file" "/home/$username/$location"
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


# Check for internet connection
[ "$(ping -c 1 9.9.9.9)" ] && echo "Success!" || echo "Please check your internet connection"


usernameandpassword || exit 1


# Adds user to sudoers file
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


# Big yikes I know
mkdir "/home/$username"/downloadmusic "/home/$username"/linuxbook "/home/$username"/memes "/home/$username"/memes/website "/home/$username"/music "/home/$username"/storagedrive "/home/$username"/scripts "/home/$username"/walls "/home/$username"/archwikidocs "/home/$username"/gitwebsite "/home/$username"/.newsboat "/home/$username"/.config/alacritty "/home/$username"/.config/dunst "/home/$username"/.config/i3 "/home/$username"/.config/mpd "/home/$username"/.config/ncmpcpp "/home/$username"/.config/nvim "/home/$username"/.config/picom "/home/$username"/.config/polybar "/home/$username"/.config/ranger "/home/$username"/.config/sxhkd "/home/$username"/.config/youtube-dl
installpackages packages.txt || exit 1


# Rename git repo directory
cp -r "/root/arch" "/home/$username/archconfig"
chown -R "$username":wheel /home/"$username"/arch

# Generates skeleton config for ranger
ranger --copy-config=all


# Put all the git repo files and folders in the right places
placeconfigs configlocations.csv || exit 1


# Change default shell to zsh
chsh -s /usr/bin/zsh
