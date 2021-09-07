#!/bin/bash
# Run script as root
# TODO
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


mkdir "/home/$username"/downloadmusic "/home/$username"/linuxbook "/home/$username"/memes "/home/$username"/memes/website "/home/$username"/music "/home/$username"/storagedrive "/home/$username"/scripts "/home/$username"/walls "/home/$username"/archwikidocs "/home/$username"/gitwebsite "/home/$username"/.newsboat "/home/$username"/alacritty "/home/$username"/dunst "/home/$username"/i3 "/home/$username"/mpd "/home/$username"/ncmpcpp "/home/$username"/nvim "/home/$username"/picom "/home/$username"/polybar "/home/$username"/ranger "/home/$username"/sxhkd "/home/$username"/youtube-dl
installpackages packages.txt || exit 1


# Rename git repo directory
cp -r "/root/arch" "/home/$username/archconfig"
chown -R "$username":wheel /home/"$username"/arch

# This command will generate skeleton config for ranger
ranger --copy-config=all


# Put all the git repo files and folders in the right places
placeconfigs configlocations.csv || exit 1


# Change default shell to zsh
chsh -s /usr/bin/zsh
