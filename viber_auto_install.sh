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












# "----------------------  Installing  Viber  ------------------------"

# Installing Viber
viber_install(){
	echo -e "\n\n######################  Installing Viber #####################"
	echo -e "##############################################################\n"

	echo -e "\n\n----------------------  Generating Viber Download link  --------------------------"
	VIBER_LINK=$(lynx --dump https://www.viber.com/download/ | grep viber.deb | sed 's/^.*http/http/')
	echo -e $VIBER_LINK
	echo -e "\n\n----------------------  Downloading Viber  --------------------------"
	wget $VIBER_LINK -O $INSTALL_LOCATION/viber_original.deb

	echo -e "\n\n----------------------  Handling Dependency problem --------------------------"
	echo -e "..... Please Wait\n"
	cd $INSTALL_LOCATION/
	dpkg-deb -x viber_original.deb viber
	dpkg-deb --control viber_original.deb viber/DEBIAN
	sed -i 's/libcurl3/libcurl4/' $INSTALL_LOCATION/viber/DEBIAN/control

	echo -e "\n\n----------------------  Generating new Viber.deb --------------------------"
	echo -e "..... Please be patient - this can take a while..\n"
	dpkg -b viber viber.deb

	echo -e "\n\n----------------------  Installing Viber package  --------------------------"
	sudo dpkg -i viber.deb

	echo -e "\n\n----------------------  Viber install cleanup  --------------------------"
	rm viber.deb viber_original.deb
	rm -R viber

	# echo -e "\n\n----------------------  Handling Scaling problem --------------------------"
	# sed -i 's/Exec=/Exec=env QT_SCALE_FACTOR=0.6 /' /usr/share/applications//viber.desktop

	log_header
	echo  "************************* Viber Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s viber | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}













echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Updating Repositories  --------------------"
echo -e "----------------------------------------------------------------"
update_repositories



echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Packages Upgrade  ----------------------"
echo -e "----------------------------------------------------------------"
# upgrade_packages




echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup





echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Viber Install  -------------------------"
echo -e "----------------------------------------------------------------"
viber_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup





echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n"
