#!/bin/bash
printf "\e[92mInstalling avahi-aliases...\e[39m\n"

printf "\e[92mInstalling dependencies...\e[39m\n"
sudo apt-get -y update
sudo apt-get -y install avahi-daemon python-avahi git

printf "\e[92mCloning avahi-aliases...\e[39m\n"
git clone https://github.com/Tugzrida/avahi-aliases.git /tmp/avahi-aliases/

printf "\e[92mCopying files...\e[39m\n"
sudo cp /tmp/avahi-aliases/avahi-publish-aliases /tmp/avahi-aliases/avahi-list-aliases /tmp/avahi-aliases/avahi-add-aliases /tmp/avahi-aliases/avahi-remove-aliases /usr/bin/
sudo cp /tmp/avahi-aliases/avahi-aliases.service /etc/systemd/system/
sudo mkdir /etc/avahi/aliases.d/
sudo touch /etc/avahi/aliases
rm -rf /tmp/avahi-aliases/

printf "\e[92mSetting permissions...\e[39m\n"
sudo chown root:root /usr/bin/avahi-publish-aliases /usr/bin/avahi-list-aliases /usr/bin/avahi-add-aliases /usr/bin/avahi-remove-aliases /etc/systemd/system/avahi-aliases.service
sudo chmod 755 /usr/bin/avahi-publish-aliases /usr/bin/avahi-list-aliases /usr/bin/avahi-add-aliases /usr/bin/avahi-remove-aliases
sudo chmod 644 /etc/systemd/system/avahi-aliases.service

printf "\e[92mStarting up...\e[39m\n"
sudo systemctl daemon-reload
sudo systemctl enable avahi-aliases.service
sudo systemctl restart avahi-daemon.service

printf "\e[92mDone! Add/remove aliases with \e[36msudo avahi-add-aliases \"alias.local\"\e[92m and \e[36msudo avahi-remove-aliases \"alias.local\"\e[39m\n"
printf "\e[92mList active aliases with \e[36mavahi-list-aliases\e[39m\n"
printf "\e[92m...or just edit \e[36m/etc/avahi/aliases\e[92m or any file in \e[36m/etc/avahi/aliases.d/\e[39m\n"
printf "\e[92mWhen you edit these files manually, run \e[36msudo systemctl restart avahi-aliases.service\e[92m afterward.\e[39m\n"
