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





# Installing GIT
git_install(){
	echo -e "\n\n######################  Installing GIT  ######################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND git

	log_header
	echo  "************************* Git Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s git | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing openssl components
openssl_install(){
	echo -e "\n\n######################  Installing openssh-server & openssh-client  #####################"
	echo -e "#########################################################################################\n"
	sudo $INSTALL_COMMAND openssh-server openssh-client

	log_header
	echo  "************************* Openssh Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s openssh-server | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s openssh-client | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo -e "\n\n######################  Installing openssl  #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND openssl
	sudo $INSTALL_COMMAND zlib1g zlib1g-dev libpcre3 libpcre3-dev libssl-dev

	log_header
	echo  "************************* Openssl Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s openssl | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing yarn
yarn_install(){
	echo -e "\n\n########################  Installing yarn  ##########################"
	echo -e "#####################################################################\n"

	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	update_repositories

	sudo $INSTALL_COMMAND yarn

	log_header
	echo  "************************* Yarn Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s yarn | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}




# "-------------------  Installing Oracle JAVA  -------------------"

java_install(){
	echo -e "\n\n######################  JAVA PPA  #####################\n"
	sudo add-apt-repository -y ppa:webupd8team/java
	update_repositories

	echo -e "\n\n######################  Installing Oracle Java  #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND oracle-java8-installer

	echo -e "\n\n######################  Installing Java Set-default #####################"
	echo -e "#########################################################################\n"
	sudo $INSTALL_COMMAND oracle-java8-set-default

	log_header
	echo  "************************* JAVA Install status *************************" >> $LOG_FILE_NAME
	dpkg -l | egrep -i oracle-java >> $LOG_FILE_NAME
	java -version >> $LOG_FILE_NAME
	which java >> $LOG_FILE_NAME
	update-alternatives --list java >> $LOG_FILE_NAME
	readlink -f "$(which java)" >> $LOG_FILE_NAME
}


# "-------------------  Installing MQTT Tools  --------------------"

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




# "------------------  Installing HTTPS Addons  -------------------"

# Install Packages to allow apt to use a repository over HTTPS
apt_https_install(){
	echo -e "\n\n######################  Installing apt-transport-https #####################"
	echo -e "############################################################################\n"
	sudo $INSTALL_COMMAND apt-transport-https

	log_header
	echo  "************************* Apt-transport-https Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s apt-transport-https | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing ca-certificates
ca_certificates_install(){
	echo -e "\n\n######################  Installing ca-certificates #####################"
	echo -e "########################################################################\n"
	sudo $INSTALL_COMMAND ca-certificates

	log_header
	echo  "************************* CA-certificates Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s ca-certificates | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}




# "-----------------  Installing Editors & IDEs  ------------------"


# Installing Visual Code editor
visualCode_install(){
	echo -e "\n\n######################  Installing Visual Code editor #####################"
	echo -e "###########################################################################\n"
	echo -e "-----------------  VS Curl Download  ------------------"
	# curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" > vscode_package.deb

	echo -e "-----------------  VS wget Download  ------------------"
	wget -r -l1 --no-parent --no-directories -e robots=off '*amd64.deb' https://go.microsoft.com/fwlink/?LinkID=760868
	mv index.html* vscode_package.deb

	sudo dpkg -i vscode_package.deb
	rm vscode_package.deb

	log_header
	echo  "************************* Visual Code Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s code | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing ATOM Editor
atom_install(){
	echo -e "\n\n######################  Atom PPA  #####################\n"
	sudo add-apt-repository -y ppa:webupd8team/atom
	update_repositories

	echo -e "\n\n######################  Installing ATOM Editor #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND atom

	log_header
	echo  "************************* Atom Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s atom | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing Brackets editor
brackets_install(){
	echo -e "\n\n######################  Brackets PPA  #####################\n"
	sudo add-apt-repository -y ppa:webupd8team/brackets
	update_repositories

	echo -e "\n\n######################  Installing Brackets editor #####################"
	echo -e "########################################################################\n"
	sudo $INSTALL_COMMAND brackets

	log_header
	echo  "************************* Brackets Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s brackets | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Midnight Commander Editor
sublime_install(){
	echo -e "\n\n#################  Installing Sublime-text Editor ################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND sublime-text

	log_header
	echo  "************************* Sublime-text Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s sublime-text | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}




# "-----------------  Installing DataBase Toosl  ------------------"

# Installing mysql-server
mysql_server_install(){
	echo -e "\n\n######################  Installing mysql-server #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND mysql-server

	log_header
	echo  "************************* MySql-server Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mysql-server | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing mysql-workbench
mysq_workbench_install(){
	echo -e "\n\n######################  Installing MySql-Workbench #####################"
	echo -e "########################################################################\n"
	sudo $INSTALL_COMMAND mysql-workbench

	log_header
	echo  "************************* MySql-Workbench Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mysql-workbench | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}




# "---------------  Installing Developement Tools  ----------------"

# Installing MELD compare
meld_install(){
	echo -e "\n\n######################  Installing MELD compare #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND meld

	log_header
	echo  "************************* MELD Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s meld | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing APT-FILE compare
apt_file_install(){
	echo -e "\n\n######################  Installing APT-FILE #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND apt-file
    apt-file update

	log_header
	echo  "************************* APT-FILE Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s apt-file | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Zeal - offline documentation viewer
zeal_install(){
	echo -e "\n\n#########################  Installing Zeal ##########################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND zeal

	log_header
	echo  "************************* Zeal Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s zeal | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

remarkable_install(){
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

	log_header
	echo  "************************* Remarkable Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s remarkable | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# "------------  Installing Docker & Docker Compose  --------------"

# Installing docker-ce docker-compose
docker_install(){
	installation_cleanup
	echo -e "\n\n######################  DOCKER apt repo  #####################\n"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	update_repositories

	echo -e "\n\n######################  Removing previous Docker Instllations  #####################"
	echo -e "####################################################################################\n"
	sudo apt-get remove docker docker-engine docker.io

	echo -e "\n\n######################  Installing docker-ce docker-compose  #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND docker-ce docker-compose

	log_header
	echo  "************************* Docker Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s docker-ce | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s docker-compose | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}




# "----------------------  Installing IDEs  -----------------------"

# Installing POSTMAN
postman_install(){
	echo -e "----------------------  Installing POSTMAN  -----------------------"
	echo -e "\n\n######################  Downloading POSTMAN #####################\n"
	wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz


	echo -e "\n\n######################  Extracting POSTMAN #####################\n"
	sudo tar -xzf postman.tar.gz -C $INSTALL_LOCATION/
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/Post*

	sudo ln -s $INSTALL_LOCATION/Postman/Postman /usr/bin/postman
	rm postman.tar.gz

	log_header
	echo  "************************* Postman Install status *************************" >> $LOG_FILE_NAME
	cat $INSTALL_LOCATION/Postman/app/version >> $LOG_FILE_NAME

}


# Installing Android Studio
android_install(){
	echo -e "\n\n--------------------------------------------------------------------------"
	echo -e "----------------------  Installing Android Studio  -----------------------"
	echo -e "--------------------------------------------------------------------------"

	echo -e "\n\n######################  Generating Android Studio Download link #####################\n"
	ANDROID_STUDIO_LINK=$(lynx --dump https://developer.android.com/studio/#downloads | grep -w linux.zip | grep https://dl.google.com | sed 's/^.*http/http/')
	echo -e $ANDROID_STUDIO_LINK

	echo -e "\n\n######################  Downloading Android Studio #####################\n"
	wget $ANDROID_STUDIO_LINK -O android_studio.zip

	echo -e "\n\n######################  Extracting Android Studio #####################\n"
	unzip android_studio.zip -d "$INSTALL_LOCATION/"
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/android*
	rm android_studio.zip

	log_header
	echo  "************************* Android Studio Install status *************************" >> $LOG_FILE_NAME
	echo -e $ANDROID_STUDIO_LINK >> $LOG_FILE_NAME
	cat $INSTALL_LOCATION/android-studio/build.txt >> $LOG_FILE_NAME

}


# NODE.js setup
node_install(){
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

	log_header
	echo  "************************* Node Install status *************************" >> $LOG_FILE_NAME
	node -v >> $LOG_FILE_NAME
	nodejs -v >> $LOG_FILE_NAME
	npm -v >> $LOG_FILE_NAME
}


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








# "--------------------  Installing  Slack  ---------------------"

# Installing Slack
slack_install(){
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

	log_header
	echo  "************************* Slack Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s slack-desktop | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}







# "------------------------  CLI tools  ---------------------------"

# CLI tools install
cli_tools_install(){
	echo -e "\n\n######################  CLI tools install #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND dstat
	sudo $INSTALL_COMMAND vnstat
	sudo $INSTALL_COMMAND htop
	sudo $INSTALL_COMMAND mycli

	log_header
	echo  "************************* CLI tools Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s dstat | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s vnstat | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s htop | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s mycli | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
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
echo -e "-----------------  Installing Essential tools  -----------------"
echo -e "----------------------------------------------------------------"
git_install
openssl_install
yarn_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installing Oracle JAVA  -------------------"
echo -e "----------------------------------------------------------------"
java_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing MQTT Tools  --------------------"
echo -e "----------------------------------------------------------------"
mqtt_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing HTTPS Addons  -------------------"
echo -e "----------------------------------------------------------------"
apt_https_install
ca_certificates_install




# Install Editors
echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing Editors & IDEs  ------------------"
echo -e "----------------------------------------------------------------"
visualCode_install
atom_install
brackets_install
sublime_install






echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup






echo -e "\n\n----------------------------------------------------------------"
echo -e "-----------------  Installing DataBase Toosl  ------------------"
echo -e "----------------------------------------------------------------"
mysql_server_install
mysq_workbench_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------  Additional Developement Tools  ----------------"
echo -e "----------------------------------------------------------------"
meld_install
apt_file_install
zeal_install
remarkable_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "------------  Installing Docker & Docker Compose  --------------"
echo -e "----------------------------------------------------------------"
docker_install



# IDE
echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------------  Installing IDEs  -----------------------"
echo -e "----------------------------------------------------------------\n\n"
postman_install
android_install
node_install
arduino_install



echo -e "\n\n---------------------------------------------------------------------------"
echo -e "---------------------------  Installing Slack  ----------------------------"
echo -e "---------------------------------------------------------------------------"
slack_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------------  CLI tools  ---------------------------"
echo -e "----------------------------------------------------------------"
cli_tools_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup




echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n"
