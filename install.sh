#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

printf "\e[92mInstalling avahi-aliases...\e[39m\n"

printf "\e[92mInstalling dependencies...\e[39m\n"
apt-get -y update
apt-get -y install avahi-daemon python3-dbus

printf "\e[92mCopying files...\e[39m\n"
script_dir=$(dirname "$0")
cp "$script_dir/avahi-publish-aliases" "$script_dir/avahi-list-aliases" "$script_dir/avahi-add-aliases" "$script_dir/avahi-remove-aliases" /usr/bin/
cp "$script_dir/avahi-aliases.service" /etc/systemd/system/
mkdir /etc/avahi/aliases.d/
touch /etc/avahi/aliases

printf "\e[92mSetting permissions...\e[39m\n"
chown root:root /usr/bin/avahi-publish-aliases /usr/bin/avahi-list-aliases /usr/bin/avahi-add-aliases /usr/bin/avahi-remove-aliases /etc/systemd/system/avahi-aliases.service
chmod 755 /usr/bin/avahi-publish-aliases /usr/bin/avahi-list-aliases /usr/bin/avahi-add-aliases /usr/bin/avahi-remove-aliases
chmod 644 /etc/systemd/system/avahi-aliases.service

printf "\e[92mStarting up...\e[39m\n"
systemctl daemon-reload
systemctl enable avahi-aliases.service
systemctl restart avahi-daemon.service

printf "\e[92mDone! Add/remove aliases with \e[36msudo avahi-add-aliases \"alias.local\"\e[92m and \e[36msudo avahi-remove-aliases \"alias.local\"\e[39m\n"
printf "\e[92mList active aliases with \e[36mavahi-list-aliases\e[39m\n"
printf "\e[92m...or just edit \e[36m/etc/avahi/aliases\e[92m or any file in \e[36m/etc/avahi/aliases.d/\e[39m\n"
printf "\e[92mWhen you edit these files manually, run \e[36msudo systemctl restart avahi-aliases.service\e[92m afterward.\e[39m\n"
