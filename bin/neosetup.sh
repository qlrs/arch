#!/bin/bash
# Must be ran as root
# Requires packages.txt and configlocations.csv in same directory
# ./setup packages.txt configlocations.csv

# Check for internet connection, exit if no internet access.
check_connection() {
    if ! ping -c 5 9.9.9.9 > /dev/null 2>&1; then
	printf "No internet access\n"
	exit 1
    fi
}

# Check if sudo is installed, exist if not installed.
sudo_check() {
    if ! command -v sudo > /dev/null 2>&1; then
	printf "Install sudo before running script\n"
	exit 1
	fi
}

# Finalize arg 1 user account.
finalize_user() {
    printf "Password: "
    read -r password
    printf "\n"
    printf "Re-type password: "
    read -r password_check
    if [[ -z "$password" ]]; then
	printf "Password can not be blank"
	exit 1
    fi

    # Check that passwords are equal
    args_equal "$password" "$password_check"

    useradd -m -g wheel -s /bin/bash "$1"
    printf "%s:%s\n" "$1" "$password" | chpasswd
}

# Check if arg 1 is equal to arg 2 strings are equal, exit if not equal.
args_equal() {
    if ! [[ "$1" == "$2" ]]; then
	printf "Passwords do not match"
	exit 1
    fi
}

# Add wheel group to sudoers. No password for wheel group when using sudo.
add_wheel_to_sudo() {
   printf "%%wheel ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers
}

# Create custom directories for arg 1 user
create_my_dirs() {
    sudo -u "$1" mkdir -p /home/"$1"/.config/{emacs,alacritty,dunst,sway,i3,i3/i3scripts,calcurse,mpd,ncmpcpp,nvim,picom,ranger} /home/"$1"/.config/alacritty/color_schemes /home/"$1"/{programs,linuxbook,stuff,stuff/website,stuff/walls,stuff/sync,stuff/books,music,storagedrive,bin,gitwebsite}
}

# Install packages listed in arg 1
install_packages() {
    while read -r; do
        pacman --noconfirm --needed -S "$REPLY"
    done < "$1"
}

# Move config repo to arg 1 user home directory and change ownership.
change_repo_owner() {
    cp -r '/root/arch' "/home/$1/archconfig"
    chown -R "$1":wheel /home/"$1"/archconfig
    chown -R "$1":wheel /home/"$1"/archconfig
}

# Move default ranger config from root user to arg 1 user
ranger_setup() {
    sudo -u "$username" ranger --copy-config=all "$1"
}

# Moves directories and files in configlocations.csv to their proper location
place_configs() {
    while IFS=, read -r file location; do
        sudo -u "$username" cp -r "/home/$username/archconfig/$file" "/home/$username/$location"
    done < "$1"
}

# Change arg 1 user default shell to zsh
set_user_shell() {
    chsh -s /usr/bin/zsh "$username"
}

# Install Paru as arg 1 user
install_paru() {
    printf "Installing Paru...\n"
    cd /home/"$1"/programs || exit 1
    sudo -u "$1" git clone https://aur.archlinux.org/paru.git
    cd paru || exit 1
    sudo -u "$1" makepkg --noconfirm -si
}

# Install dmenu as arg 1 user
install_dmenu() {
    printf "Installing dmenu...\n"
    cd "/home/$1/programs" || exit 1
    sudo -u "$username" git clone https://codeberg.org/qlrs/dmenu
    cd dmenu || exit 1
    sudo make clean install
}

# I think this is necessary???
setup_mpd() {
    sudo -u "$1" touch "/home/$username/.config/mpd/{mpd.db,mpd.log,mpd.pid}"
}

# Create todo list for things I haven't added to this script yet. Arg 1 is username
create_todo() {
    cat <<EOF
AUR packages: brave-bin, ffuf, git-dumper-git, gobuster, john-git, netexec, opustags, ruby-evil-winrm, steghide, ttf-aporetic
Copy over SSH key to my machine
Change pacman conf to show colors, parallel downloads, and ILoveCandy
Change mirrors to https (https://archlinux.org/mirrorlist/)
Configure dns-crypt (
listen_addresses = ['mullvad-doh', 'quad9-dnscrypt-ip4-nofilter-pri'])
Enable dnscrypt with systemd
Setup Syncthing (enable with systemd)
Enable fstrim.timer service (install util-linux if not available)
EOF
}

main() {
    check_connection

    sudo_check

    # Get username in "global" scope
	#    printf "Username: "
	#    read -r username
	#    printf "\n"
	#    if [ -z "$username" ]; then
	# printf "Username can not be blank"
	# exit 1
	#    fi
	#
	#    finalize_user "$username"
	#
	#    [[ -f /etc/sudoers.pacnew ]] && cp /etc/sudoers.pacnew /etc/sudoers
	#    [[ -e /var/lib/pacman/db.lck ]] && rm /var/lib/pacman/db.lck
	#
    username='dan'
    add_wheel_to_sudo

    create_my_dirs "$username"

    install_packages "$1" # packages.txt

    change_repo_owner "$username"

    ranger_setup "$username"

    place_configs "$2" # configlocations.csv

    set_user_shell "$username"

    install_paru "$username"

    install_dmenu "$username"

    setup_mpd "$username"

    #download_wallpapers "$username"

    create_todo "/home/$username/todolist.txt"
}

main "$1" "$2"
# TODO
# Install lazy vim
