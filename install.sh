#!/bin/bash

# Backup
mkdir -p ~/.config/master-desktop/backup
cp -rf ~/.config ~/.config/master-desktop/backup/
cp -rf ~/.bashrc ~/.config/master-desktop/backup/

# Install dependencies
trizen -S --noconfirm lxappearance gnome-control-center xorg-xfdttf-font-awesome feh dunst rofi \
python-i3ipc i3lock dmenu i3-gaps siji-git nerd-fonts-complete inotify-tools maim redshift \
picom-tryone-git tilix kdeconnect ethtool nmap net-tools jq kvantum-qt5 imagemagick xdotool \
xclip dolphin gotop papirus-icon-theme dialog

ARG=$1
if [ -z "${ARG}" ]; then
    MOD_KEY=$(bin/dialog --backtitle "Master Desktop" \
            --title "i3 Mod Key" \
            --menu "Select your mod key for i3" 15 70 2 "Alt Win" \
            3>&1 1>&2 2>&3 3>&-)
else
    MOD_KEY=${ARG}
fi

if [ "${MOD_KEY}" == "Alt" ]; then
    MOD="Mod1"
else
    MOD="Mod4"
fi

sed -i -e "s/{{MODKEY}}/${MOD}/g" ./dotfiles/.config/i3/config

# Install Bash-It
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent
sed -i -e 's/bobby/powerline-multiline/g' ~/.bashrc

# Install files
cp -rf ./dotfiles/ ~/

echo "Master Desktop installed. Logout and choose i3 in your login screen."
echo "For those without a DM, launch i3"
echo ""
echo "Your original configurations and desktop was backuped up to:"
echo "~/.config/master-desktop/backup/"