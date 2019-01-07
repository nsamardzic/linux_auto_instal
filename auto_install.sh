#!/bin/bash

# **************************************
# Initial developement setup for Linux *
# **************************************

# ---------------------------------------------------------------------
# Name             : Favorite Quotes - Main variables file
# Description      : Bash script for Linux Initial setup - developement env
# Created By       : Nenad Samardzic
# License          : GNU GENERAL PUBLIC LICENSE Version 3,
# Date:            : September 2018
# Powered          : Bash
# ---------------------------------------------------------------------

# To Make this script executable chmod +x <script_name>.
# To use the script type: ./<script_name>.
# Example: ./my_apps.sh

# ---------------------------------------------------------------------


echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------------  Variables  --------------------------"
echo -e "----------------------------------------------------------------"



# Username of the user that is performing the installation
LINUX_USER=ime

# Target folder name (absolute path) to which you want your tar.gz type of apps to be installed/unpacked
# This script assumes that this location is within "HOME" folder
INSTALL_LOCATION=~/Applications

# Defines which package manager/install command/switches for the package installation
INSTALL_COMMAND='apt-get install -y'



# **************************************
# This conditional checks if theres existing INSTALL_LOCATION folder, and if not it creates it
# Also, folder is chown to home user privilages - user is defined in LINUX_USER variable

if [ ! -d "$INSTALL_LOCATION" ];
then
	mkdir -p $INSTALL_LOCATION
fi

chown $LINUX_USER $INSTALL_LOCATION

# **************************************


# Add PPA sources
echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Adding PPA Sources  --------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  JAVA PPA  #####################\n"
sudo add-apt-repository -y ppa:webupd8team/java

echo -e "\n\n######################  Brackets PPA  #####################\n"
sudo add-apt-repository -y ppa:webupd8team/brackets

echo -e "\n\n######################  Atom PPA  #####################\n"
sudo add-apt-repository -y ppa:webupd8team/atom

echo -e "\n\n######################  LibreOffice PPA  #####################\n"
sudo add-apt-repository -y ppa:libreoffice/ppa

echo -e "\n\n######################  DOCKER apt repo  #####################\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

echo -e "\n\n######################  Weather Indicator via PPA  #####################\n"
sudo add-apt-repository -y ppa:kasra-mp/ubuntu-indicator-weather




# To get the latest package lists
echo -e "\n\n######################  Updating Repositories  #####################"
echo -e "####################################################################\n"
sudo apt-get update

# Upgrade to latest package lists
echo -e "\n\n######################  Packages Upgrade  #####################"
echo -e "###############################################################\n"
sudo apt-get -y upgrade



echo -e "\n\n######################  Installation cleanup 01 #####################"
echo -e "#####################################################################\n"
sudo apt-get -y autoclean
sudo apt-get -y clean
sudo apt-get -y autoremove
sudo apt-get -y install -f
sudo apt-get update --fix-missing



# Install Essential tools
echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing Essential tools  -----------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing build-essential  #####################"
echo -e "#########################################################################\n"
sudo $INSTALL_COMMAND build-essential

echo -e "\n\n######################  Installing software-properties-common  #####################"
echo -e "####################################################################################\n"
sudo $INSTALL_COMMAND software-properties-common

echo -e "\n\n######################  Installing python-software-properties  #####################"
echo -e "####################################################################################\n"
sudo $INSTALL_COMMAND python-software-properties

echo -e "\n\n######################  Installing openssh-server & openssh-client  #####################"
echo -e "#########################################################################################\n"
sudo $INSTALL_COMMAND openssh-server openssh-client

echo -e "\n\n######################  Installing openssl  #####################"
echo -e "#################################################################\n"
sudo $INSTALL_COMMAND openssl
sudo $INSTALL_COMMAND zlib1g zlib1g-dev libpcre3 libpcre3-dev libssl-dev

echo -e "\n\n######################  Installing GIT  ######################"
echo -e "##############################################################\n"
sudo $INSTALL_COMMAND git

echo -e "\n\n######################  Installing Curl  ######################"
echo -e "###############################################################\n"
sudo $INSTALL_COMMAND curl

echo -e "\n\n######################  Installing python-pip  #####################"
echo -e "####################################################################\n"
sudo $INSTALL_COMMAND python-pip
pip -V

echo -e "\n\n######################  Installing python3-pip  #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND python3-pip
pip3 -V

echo -e "\n\n######################  Installing Lynx #####################"
echo -e "#############################################################\n"
sudo $INSTALL_COMMAND lynx

echo -e "\n\n########################  Installing yarn  ##########################"
echo -e "#####################################################################\n"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo $INSTALL_COMMAND yarn



# Install Oracle Java
echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installing Oracle JAVA  -------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing Oracle Java  #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND oracle-java8-installer

echo -e "\n\n######################  Installing Java Set-default #####################"
echo -e "#########################################################################\n"
sudo $INSTALL_COMMAND oracle-java8-set-default

echo -e "\n-------------------  Java version details -------------------"
java -version
which java




# Multimedia
echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------  Installing Multimedia tools  -----------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing ubuntu-restricted-extras  #####################"
echo -e "##################################################################################\n"
sudo $INSTALL_COMMAND ubuntu-restricted-extras


echo -e "\n\n######################  Installing Microsoft core fonts  #####################"
echo -e "##############################################################################\n"
sudo $INSTALL_COMMAND msttcorefonts


echo -e "\n\n######################  Installing flashplugin-installer  #####################"
echo -e "###############################################################################\n"
sudo $INSTALL_COMMAND flashplugin-installer

echo -e "\n\n######################  Installing DVD libdvdread4  #####################"
echo -e "#########################################################################\n"
sudo $INSTALL_COMMAND libdvdcss2 libdvdread4 libdvdnav4
sudo /usr/share/doc/libdvdread4/install-css.sh

echo -e "\n\n######################  Installing VLC Player  #####################"
echo -e "####################################################################\n"
sudo $INSTALL_COMMAND vlc

echo -e "\n\n######################  Installing SMPlayer  #####################"
echo -e "##################################################################\n"
sudo $INSTALL_COMMAND smplayer

echo -e "\n\n#####################  Installing Audacious  #####################"
echo -e "##################################################################\n"
sudo $INSTALL_COMMAND audacious
sudo $INSTALL_COMMAND audacious-plugins

echo -e "\n\n######################  Installing Audacity  #####################"
echo -e "##################################################################\n"
sudo $INSTALL_COMMAND audacity
sudo $INSTALL_COMMAND audacity-data




# MQTT tools
echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------=---  Installing MQTT Tools  --------------------"
echo -e "----------------------------------------------------------------"
echo -e "\n\n######################  Installing mosquitto & mosquitto-clients  #####################"
echo -e "#######################################################################################\n"
sudo $INSTALL_COMMAND mosquitto mosquitto-clients

echo -e "\n\n######################  Installing paho-mqtt  #####################"
echo -e "###################################################################\n"
sudo -H pip install paho-mqtt




echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------  Installing Compression Tools  -----------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing General Compression tools #####################"
echo -e "##################################################################################\n"
sudo $INSTALL_COMMAND p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller




echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing HTTPS Addons  -------------------"
echo -e "----------------------------------------------------------------"

# Install Packages to allow apt to use a repository over HTTPS
echo -e "\n\n######################  Installing apt-transport-https #####################"
echo -e "############################################################################\n"
sudo $INSTALL_COMMAND apt-transport-https

echo -e "\n\n######################  Installing ca-certificates #####################"
echo -e "########################################################################\n"
sudo $INSTALL_COMMAND ca-certificates





# Install Various Tools
echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing Tools & Soft  -------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing dconf #####################"
echo -e "##############################################################\n"
sudo $INSTALL_COMMAND dconf-cli dconf-editor

echo -e "\n\n######################  Installing KeePassX #####################"
echo -e "#################################################################\n"
sudo $INSTALL_COMMAND keepassx

echo -e "\n\n######################  Installing DropBox #####################"
echo -e "################################################################\n"
sudo $INSTALL_COMMAND dropbox


echo -e "\n\n######################  Installing Krusader #####################"
echo -e "#################################################################\n"
sudo $INSTALL_COMMAND krusader
sudo $INSTALL_COMMAND krename

echo -e "\n\n######################  Installing Gparted with dependencies #####################"
echo -e "##################################################################################\n"
sudo $INSTALL_COMMAND gparted
sudo $INSTALL_COMMAND udftools
sudo $INSTALL_COMMAND reiser4progs
sudo $INSTALL_COMMAND hfsutils
sudo $INSTALL_COMMAND f2fs-tools
sudo $INSTALL_COMMAND f2fs-tools
sudo $INSTALL_COMMAND nilfs-tools
sudo $INSTALL_COMMAND exfat-utils exfat-fuse


echo -e "\n\n######################  Installing HardInfo #####################"
echo -e "#################################################################\n"
sudo $INSTALL_COMMAND hardinfo

echo -e "\n\n######################  Installing ScreenFetch #####################"
echo -e "####################################################################\n"
sudo $INSTALL_COMMAND screenfetch

echo -e "\n\n######################  Installing Shutter #####################"
echo -e "################################################################\n"
sudo $INSTALL_COMMAND shutter

echo -e "\n\n######################  Installing SreenRuller #####################"
echo -e "####################################################################\n"
sudo $INSTALL_COMMAND screenruler

echo -e "\n\n######################  Installing Konsole #####################"
echo -e "################################################################\n"
sudo $INSTALL_COMMAND konsole

echo -e "\n\n######################  Installing Terminator #####################"
echo -e "###################################################################\n"
sudo $INSTALL_COMMAND terminator

echo -e "\n\n######################  Installing indicator-weather #####################"
echo -e "##########################################################################\n"
sudo $INSTALL_COMMAND indicator-weather

echo -e "\n\n######################  Installing indicator-cpufreq #####################"
echo -e "##########################################################################\n"
sudo $INSTALL_COMMAND indicator-cpufreq

echo -e "\n\n###########################  Installing synapse ##########################"
echo -e "##########################################################################\n"
sudo $INSTALL_COMMAND synapse

echo -e "\n\n#########################  Installing SpeedCrunch ########################"
echo -e "##########################################################################\n"
sudo $INSTALL_COMMAND speedcrunch




# Install Samba share
echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing SAMBA share  --------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing Samba #####################"
echo -e "##############################################################\n"
sudo $INSTALL_COMMAND samba samba-common python-dnspython

echo -e "\n\n######################  WhereIs Samba #####################"
echo -e "###########################################################\n"
whereis samba




# Install Editors
echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing Editors & IDEs  ------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Installing Geany editor #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND geany

echo -e "\n\n######################  Installing MC Editor #####################"
echo -e "##################################################################\n"
sudo $INSTALL_COMMAND mc

echo -e "\n\n######################  Installing ATOM Editor #####################"
echo -e "####################################################################\n"
sudo $INSTALL_COMMAND atom

echo -e "\n\n######################  Installing Brackets editor #####################"
echo -e "########################################################################\n"
sudo $INSTALL_COMMAND brackets

echo -e "\n\n######################  Installing Visual Code editor #####################"
echo -e "###########################################################################\n"
echo -e "-----------------  VS Curl Download  ------------------"
# curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" > vscode_package.deb
echo -e "-----------------  VS wget Download  ------------------"
wget -r -l1 --no-parent --no-directories -e robots=off '*amd64.deb' https://go.microsoft.com/fwlink/?LinkID=760868
mv index.html* vscode_package.deb
sudo dpkg -i vscode_package.deb
rm vscode_package.deb


echo -e "\n\n#################  Installing Sublime-text Editor ################"
echo -e "##################################################################\n"
sudo $INSTALL_COMMAND sublime-text 


echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------- Installing Snap package manager  ----------------"
echo -e "----------------------------------------------------------------"

# Database
echo -e "\n\n######################  Installing SNAP #####################"
echo -e "#############################################################\n"
sudo $INSTALL_COMMAND snapd

echo -e "\n\n######################  Adding Snap PATH to bashrc  #####################"
echo -e "#########################################################################\n"
echo -e 'export PATH="$PATH:/snap/bin"' >> ~/.bashrc





echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing DataBase Toosl  ------------------"
echo -e "----------------------------------------------------------------"

# Database
echo -e "\n\n######################  Installing mysql-server #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND mysql-server

echo -e "\n\n######################  Installing mysql-workbench #####################"
echo -e "########################################################################\n"
sudo $INSTALL_COMMAND mysql-workbench


echo -e "\n\n######################  Installing MELD compare #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND meld


echo -e "\n\n######################  Installing Arduino #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND arduino-core
sudo $INSTALL_COMMAND arduino
sudo $INSTALL_COMMAND librxtx-java libjna-java
sudo adduser $LINUX_USER dialout




echo -e "\n\n######################  Installation cleanup 02  #####################"
echo -e "######################################################################\n"
sudo apt-get -y autoclean
sudo apt-get -y clean
sudo apt-get -y autoremove
sudo apt-get -y install -f
sudo apt-get update --fix-missing




# DOCKER
echo -e "\n\n----------------------------------------------------------------"
echo -e "------------  Installing Docker & Docker Compose  --------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Removing previous Docker Instllations  #####################"
echo -e "####################################################################################\n"
sudo apt-get remove docker docker-engine docker.io

echo -e "\n\n######################  Installing docker-ce docker-compose  #####################"
echo -e "##################################################################################\n"
sudo $INSTALL_COMMAND docker-ce docker-compose



echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installing Browsers  ---------------------"
echo -e "----------------------------------------------------------------"

# Install Browsers
echo -e "\n\n######################  Installing CHROMIUM #####################"
echo -e "#################################################################\n"
sudo $INSTALL_COMMAND chromium-browser

echo -e "\n\n######################  Installing OPERA #####################"
echo -e "##############################################################\n"
sudo $INSTALL_COMMAND opera

echo -e "\n\n######################  Installing CHROME #####################"
echo -e "###############################################################\n"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb


echo -e "\n\n---------------------------------------------------------------------------"
echo -e "--------------------  Installing Skype, Viber, Slack  ---------------------"
echo -e "---------------------------------------------------------------------------"

echo -e "\n\n######################  Installing Skype #####################"
echo -e "###############################################################\n"
wget https://go.skype.com/skypeforlinux-64.deb -O skype_amd64.deb
sudo dpkg -i skype_amd64.deb
rm skype_amd64.deb

echo -e "\n\n###################### Installing Slack #####################"
echo -e "#############################################################\n"

echo -e "\n\n----------------------  Generating Slack Download link  --------------------------"
SLACK_LINK=$(lynx --dump https://slack.com/downloads/instructions/ubuntu | grep amd64.deb | sed 's/^.*http/http/')
echo -e $SLACK_LINK

echo -e "\n\n----------------------  Downloading Slack  --------------------------"
wget $SLACK_LINK -O slack_amd64.deb

echo -e "\n\n----------------------  Installing Slack package  --------------------------"
sudo dpkg -i slack_amd64.deb
rm slack_amd64.deb


echo -e "\n\n######################  Installing Viber #####################"
echo -e "##############################################################\n"
echo -e "\n\n----------------------  Generating Viber Download link  --------------------------"
VIBER_LINK=$(lynx --dump https://www.viber.com/download/ | grep viber.deb | sed 's/^.*http/http/')
echo -e $VIBER_LINK
echo -e "\n\n----------------------  Downloading Viber  --------------------------"
wget $VIBER_LINK -O viber.deb

echo -e "\n\n----------------------  Installing Viber package  --------------------------"
sudo dpkg -i viber.deb
rm viber.deb




# NODE.js setup
echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------------  NODE.js setup  ------------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n----------------------  Downloading NODE.js  --------------------------"
wget -r -l1 --no-parent --no-directories -e robots=off -A '*linux-x64.tar.gz' https://nodejs.org/download/release/latest/

echo -e "\n\n----------------------  Extracting NODE.js to INSTALL_LOCATION  --------------------------"
sudo tar -xzf *linux-x64.tar.gz -C $INSTALL_LOCATION/

echo -e "\n\n----------------------  Renaming to NODE_INSTALL --------------------------"
mv $INSTALL_LOCATION/node-* $INSTALL_LOCATION/node_install

echo -e "\n\n----------------------  Chown Directory & Deleting NODEjs Download --------------------------"
sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/node*
rm *linux-x64.tar.gz

echo -e "\n\n----------------------  Adding NODEjs PATH to bashrc --------------------------"
echo -e 'export PATH="$PATH:~/Applications/node_install/bin"' >> ~/.bashrc #edit this location per your folder settilgs

echo -e "\n\n----------------------  Creating NODEjs lnk --------------------------"
sudo sudo ln -s $INSTALL_LOCATION/node_install/bin/node /usr/bin/nodejs
sudo sudo ln -s $INSTALL_LOCATION/node_install/bin/node /usr/bin/node

echo -e "\n-----  Check NODE path 7 version  ------"
node -v
nodejs -v
npm -v




echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------------  YOUTUBE_DL setup  -----------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  YOUTUBE_DL preconditions #####################\n"
sudo $INSTALL_COMMAND ffmpeg rtmpdump
mkdir $INSTALL_LOCATION/youtube_downloader

echo -e "\n\n######################  Downloading YOUTUBE_DL #####################\n"
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O $INSTALL_LOCATION/youtube_downloader/youtube-dl
sudo chmod 755 $INSTALL_LOCATION/youtube_downloader/youtube-dl
sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/youtube_downloader
cd $INSTALL_LOCATION/youtube_downloader

echo -e "\n\n######################  YOUTUBE_DL Installed #####################\n"
./youtube-dl --version





echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  VirtualBox setup  ----------------------"
echo -e "----------------------------------------------------------------"

echo -e "\n\n######################  Generating VirtualBox Download link #####################\n"
VIRTUALBOX_LINK=$(lynx --dump https://www.virtualbox.org/wiki/Linux_Downloads | grep -w bionic_amd64.deb | sed 's/^.*http/http/')
echo -e $VIRTUALBOX_LINK

echo -e "\n\n###############  Generating VirtualBox Extension Pack Download link ###################\n"
VIRTUALBOX_EXTENSION_LINK=$(lynx --dump https://www.virtualbox.org/wiki/Downloads | grep -w vbox-extpack | sed 's/^.*http/http/')
echo -e $VIRTUALBOX_EXTENSION_LINK

echo -e "\n\n####################  Downloading VirtualBox & Extension Pack #####################\n"
wget $VIRTUALBOX_LINK -O VirtualBox.deb
wget $VIRTUALBOX_EXTENSION_LINK -O Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack

echo -e "\n\n####################  Installing VirtualBox & Extension Pack #####################\n"
sudo dpkg -i VirtualBox.deb
rm VirtualBox.deb





echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Developement tools  ----------------------"
echo -e "----------------------------------------------------------------\n\n"

echo -e "\n\n######################  Installing MELD compare #####################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND meld

echo -e "\n\n#########################  Installing zeal ##########################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND zeal

echo -e "\n\n########################  QT5 install ########################"
echo -e "##############################################################\n"
sudo $INSTALL_COMMAND python3-pyqt5.qtwebkit
sudo $INSTALL_COMMAND mesa-common-dev
sudo $INSTALL_COMMAND libglu1-mesa-dev
sudo $INSTALL_COMMAND libfontconfig1
sudo pip install PyQt5


echo  "\n\n###################  Installing Remarkable ###################"
echo  "##############################################################\n"
echo  "\n\n----------------------  Generating Remarkable Download link  --------------------------"
REMARKABLE_LINK=$(lynx --dump https://remarkableapp.github.io/linux/download.html | grep all.deb | sed 's/^.*http/http/')
echo $REMARKABLE_LINK
echo -e "\n\n----------------------  Downloading Remarkable  --------------------------"
wget $REMARKABLE_LINK -O remarkable.deb
echo -e "\n\n----------------------  Installing Remarkable package  --------------------------"
sudo dpkg -i remarkable.deb
rm remarkable.deb

echo -e "\n\n#########################  Retext Markdown ##########################"
echo -e "#####################################################################\n"
sudo $INSTALL_COMMAND retext

echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------------  ZSH and Oh-My-Zsh  ----------------------"
echo -e "----------------------------------------------------------------\n\n"

echo -e "\n\n################  ZSH and Oh-My-Zsh Install ##################"
echo -e "##############################################################\n"
apt-get install -y zsh git-core
apt-get install -y zsh-syntax-highlighting
apt-get install -y zsh-theme-powerlevel9k
apt-get install -y powerline fonts-powerline
zsh --version
which zsh
whereis zsh
sudo usermod -s /usr/bin/zsh $(whoami)
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc






# Postman
echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Installing IDEs  -----------------------"
echo -e "----------------------------------------------------------------\n\n"

echo -e "----------------------  Installing POSTMAN  -----------------------"

echo -e "\n\n######################  Downloading POSTMAN #####################\n"
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz

echo -e "\n\n######################  Extracting POSTMAN #####################\n"
sudo tar -xzf postman.tar.gz -C $INSTALL_LOCATION/
sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/Post*

rm postman.tar.gz
sudo ln -s $INSTALL_LOCATION/Postman/Postman /usr/bin/postman




echo -e "\n\n----------------------  Installing Android Studio  -----------------------"
echo -e "--------------------------------------------------------------------------\n\n"

echo -e "\n\n######################  Generating Android Studio Download link #####################\n"
ANDROID_STUDIO_LINK=$(lynx --dump https://developer.android.com/studio/#downloads | grep -w linux.zip | grep https://dl.google.com | sed 's/^.*http/http/')
echo -e $ANDROID_STUDIO_LINK

echo -e "\n\n######################  Downloading Android Studio #####################\n"
wget $ANDROID_STUDIO_LINK -O android_studio.zip

echo -e "\n\n######################  Extracting Android Studio #####################\n"
unzip android_studio.zip -d "$INSTALL_LOCATION/"
sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/android*

rm android_studio.zip




echo -e "\n\n######################  CLI tool install #####################"
echo -e "##############################################################\n"
sudo $INSTALL_COMMAND dstat
sudo $INSTALL_COMMAND vnstat
sudo $INSTALL_COMMAND htop
sudo $INSTALL_COMMAND mycli





echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Post-Installation Cleanup  -----------------"
echo -e "----------------------------------------------------------------\n\n"

# Installation cleanup
sudo apt-get -y autoclean
sudo apt-get -y clean
sudo apt-get -y autoremove
sudo apt-get -y install -f
sudo apt-get update --fix-missing


echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n\n"
