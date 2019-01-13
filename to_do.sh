#!/bin/bash

# **************************************
# Initial developement setup for Linux *
# **************************************

# ---------------------------------------------------------------------
# Name             : Linux Auto-install 
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





# "----------------------------------------------------------------"
# "-------------------------  Variables  --------------------------"
# "----------------------------------------------------------------"

# Username of the user that is performing the installation
LINUX_USER=ime

# Target folder name (path) to which you want your tar.gz type of apps to be installed/unpacked
# This script assumes that this location is within "HOME" folder
INSTALL_LOCATION=~/Applications

# Defines which package manager/install command/switches for the package installation
INSTALL_COMMAND='apt-get install -y'

# Defines log file name for implemented loging per function call
LOG_FILE_NAME=Install_log.txt



# *********************************************************************************
# This conditional checks if theres existing INSTALL_LOCATION folder, and if not it creates it
# Also, folder is chown to home user privilages - user is defined in LINUX_USER variable

if [ ! -d "$INSTALL_LOCATION" ];
then
	mkdir -p $INSTALL_LOCATION
fi

chown $LINUX_USER $INSTALL_LOCATION

# *********************************************************************************








# Updating Repositories
update_repositories(){
	echo -e "\n\n######################  Updating Repositories  #####################"
	echo -e "####################################################################\n"
	sudo apt-get update
}


# Upgrade to latest package lists
upgrade_packages(){
	echo -e "\n\n######################  Packages Upgrade  #####################"
	echo -e "###############################################################\n"
	sudo apt-get -y upgrade
}


# Installation cleanup
installation_cleanup(){
	echo -e "\n\n######################  Installation cleanup  #####################"
	echo -e "#####################################################################\n"
	sudo apt-get -y autoclean
	sudo apt-get -y clean
	sudo apt-get -y autoremove
	sudo apt-get -y install -f
	sudo apt-get update --fix-missing
}


log_header(){
	
	echo >> $LOG_FILE_NAME
	echo >> $LOG_FILE_NAME
	echo "Installed on:   $(date)" >> $LOG_FILE_NAME
}































# "-----------------------------  Arduino Install  --------------------------------"

# Installing Arduino
arduino_install(){
	echo -e "\n\n######################  Installing Arduino #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND arduino-core
	sudo $INSTALL_COMMAND librxtx-java libjna-java

	echo  "\n\n----------------------  Generating Arduino Download link  --------------------------"
	ARDUINO_LINK=$(lynx --dump https://www.arduino.cc/en/Main/Software | grep linux64.tar.xz | sed 's/^.*http/http/')
	echo $ARDUINO_LINK

	echo -e "\n\n----------------------  Downloading Arduino  --------------------------"
	wget $ARDUINO_LINK -O arduino.tar.xz

	echo -e "\n\n----------------------  Extracting Arduino to INSTALL_LOCATION  --------------------------"
	
	sudo adduser $LINUX_USER dialout
}










# "-----------------------------  PIP Install  --------------------------------"

# Installing python-pip
pip_install(){
	echo -e "\n\n######################  Installing python-pip  #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND python-pip
	
	log_header
	echo  "************************* PIP Install status *************************" >> $LOG_FILE_NAME
	pip -V >> $LOG_FILE_NAME
}


# Installing python-pip3
pip3_install(){
	echo -e "\n\n######################  Installing python3-pip  #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND python3-pip

	log_header
	echo  "************************* PIP3 Install status *************************" >> $LOG_FILE_NAME
	pip3 -V >> $LOG_FILE_NAME
}








# "-----------------------------  MQTT Install  --------------------------------"

# Installing MQTT Tools
mqtt_install(){
	echo -e "\n\n----------------------------------------------------------------"
	echo -e "-------------------  Installing MQTT Tools  --------------------"
	echo -e "----------------------------------------------------------------"
	echo -e "\n\n######################  Installing mosquitto & mosquitto-clients  #####################"
	echo -e "#######################################################################################\n"
	sudo $INSTALL_COMMAND mosquitto mosquitto-clients

	log_header
	echo  "************************* Mosquitto Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mosquitto | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing paho-mqtt
paho_mqtt_install(){
	echo -e "\n\n######################  Installing Paho-mqtt  #####################"
	echo -e "###################################################################\n"
	sudo -H pip install paho-mqtt

	log_header
	echo  "************************* Paho-mqtt Install status *************************" >> $LOG_FILE_NAME
	sudo pip show paho-mqtt >> $LOG_FILE_NAME
}






# "------------------------  QT5 Install  ---------------------------"

# QT5 install
qt5_install(){
	echo -e "\n\n########################  QT5 install ########################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND python3-pyqt5.qtwebkit
	sudo $INSTALL_COMMAND mesa-common-dev
	sudo $INSTALL_COMMAND libglu1-mesa-dev
	sudo $INSTALL_COMMAND libfontconfig1

	sudo pip install PyQt5
	
	log_header
	echo  "************************* QT5 Install status *************************" >> $LOG_FILE_NAME
	pip show PyQt5 >> $LOG_FILE_NAME
}






# "------------------------  VirtualBox Install  ---------------------------"

# Installing VirtualBox & Extension Pack
virtualbox_install(){
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

	log_header
	echo  "************************* VirtualBox Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s virtualbox | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}













update_repositories



installation_cleanup







# virtualbox_install



# pip_install
# pip3_install
# mqtt_install
# paho_mqtt_install
# qt5_install

# arduino_install

installation_cleanup








echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n"
