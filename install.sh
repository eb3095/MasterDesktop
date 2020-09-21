#!/bin/bash

# Functions

function setupInstaller {
    sed -i -e 's/# %wheel ALL=(ALL) NOPASSWD\: ALL/%wheelnpw ALL=(ALL) NOPASSWD\: ALL/' /etc/sudoers
    groupadd wheelnpw
    useradd installer
    usermod -aG wheelnpw installer
    mkdir /home/installer
    chown installer:installer /home/installer

    # Install trizen
    pushd /tmp
    git clone https://aur.archlinux.org/trizen.git
    popd
    chmod -R 777 /tmp/trizen
    runuser -l installer -c 'cd /tmp/trizen; makepkg -si --noconfirm'
    rm -rf /tmp/trizen
}

function install_pkgs {
    packs=$@
    runuser -l installer -c "trizen -Sy --noconfirm ${packs}"
}

function removeInstaller {
    userdel installer
    rm -rf /home/installer
}

# Backup
mkdir -p ~/.config/master-desktop/backup
cp -rf ~/.config ~/.config2
cp -rf ~/.config2 ~/.config/master-desktop/backup/.config
cp -rf ~/.bashrc ~/.config/master-desktop/backup/

# Install dependencies
install_pkgs lxappearance gnome-control-center xorg-xfdttf-font-awesome feh dunst rofi \
python-i3ipc i3lock dmenu i3-gaps siji-git inotify-tools maim redshift \
picom-git tilix kdeconnect ethtool nmap net-tools jq kvantum-qt5 imagemagick xdotool \
xclip dolphin gotop papirus-icon-theme dialog systemsettings python-papirus

pip install python-mdp2

# Setup nerd fonts
mv /tmp /tmp2
mkdir /tmp
install_pkgs nerd-fonts-complete
/bin/rm -rf /tmp
mv /tmp2 /tmp

# Get arguments
ARG1=$1
ARG2=$2

# Get default interface
if [ "${ARG1}" == "--automated" ]; then
    for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
    do
        if [ "${iface}" == "lo" ]; then
            continue
        fi

        if [ `cat /sys/class/net/${iface}/operstate` != "up" ]; then
            continue
        fi

        if [ `ethtool -P ${iface} | tail -n 1 | awk -F' ' '{print $3}'` == "00:00:00:00:00:00" ]; then
            continue
        fi

        INTERFACE=${iface}
        break;
    done
else
    INTERFACES=($(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF))
    COUNT=${#INTERFACES[@]}
    for (( c=0; c<${#INTERFACES[@]}; c++ ))
    do
        INTERFACE_LIST+=( "${INTERFACES[$c]}" )
        INTERFACE_LIST+=( "${INTERFACES[$c]}" )
    done
    INTERFACE=$(dialog --backtitle "Master Desktop" \
            --title "Interface Selection" \
            --menu "Choose your default interface" 15 70 $count "${INTERFACE_LIST[@]}" \
            3>&1 1>&2 2>&3 3>&-)
fi

# Get user mod key for i3
if [ -z "${ARG2}" ]; then
    MOD_KEY=$(dialog --backtitle "Master Desktop" \
            --title "i3 Mod Key" \
            --menu "Select your mod key for i3" 15 70 2 "Alt Alt Win Win" \
            3>&1 1>&2 2>&3 3>&-)
else
    MOD_KEY=${ARG2}
fi

if [ "${MOD_KEY}" == "Alt" ]; then
    MOD="Mod1"
else
    MOD="Mod4"
fi

# Configure
sed -i -e "s/{{MODKEY}}/${MOD}/g" ./dotfiles/.config/i3/config
sed -i -e "s/{{INTERFACE}}/${INTERFACE}/g" ./dotfiles/.config/polybar/config

# Install Bash-It
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent
sed -i -e 's/bobby/powerline/g' ~/.bashrc

# Install files
cp -rf ./dotfiles/.config ~/
cp -rf ./dotfiles/.icons ~/
cp -rf ./dotfiles/.themes ~/

# Remove installer
removeInstaller

# Done!
echo "Master Desktop installed. Logout and choose i3 in your login screen."
echo "For those without a DM, launch i3"
echo ""
echo "Your original configurations and desktop was backuped up to:"
echo "~/.config/master-desktop/backup/"