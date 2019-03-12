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





# System Reboot
system_reboot(){
	echo -e "\n\n#######################  Reboot System  #######################"
	echo -e "###############################################################\n"
	sudo reboot
}


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








# "------------------------  Python3 Install ---------------------------"

# Python3install
python3_install(){
	echo -e "\n\n#####################  Python3 Install #######################"
	echo -e "##############################################################\n"

	sudo $INSTALL_COMMAND python3.7 python3.7-doc python3.7-dbg
  sudo $INSTALL_COMMAND python3.7-venv python3.7-examples



	echo -e "\n\n####################  Adding Python3 Alias to bashrc  ####################"
	echo -e "#########################################################################\n"
	echo -e "alias python='/usr/bin/python3.7'" >> ~/.bashrc

	echo -e "\n\n############################  Reload bashrc  ############################"
	echo -e "#########################################################################\n"
	source ~/.bashrc


	log_header
	echo  "************************* Python3 Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s python3.7 | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	python --version >> $LOG_FILE_NAME
	which python >> $LOG_FILE_NAME
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
echo -e "---------------------  Python3_install  ------------------------"
echo -e "----------------------------------------------------------------"
python3_install









echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup





echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n"



echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Reboot System  -------------------------"
echo -e "----------------------------------------------------------------"
system_reboot
