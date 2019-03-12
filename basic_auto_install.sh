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






# "-----------------  Installing Essential tools  -----------------"

# Installing build-essential
build_essentials_install(){
	echo -e "\n\n######################  Installing build-essential  #####################"
	echo -e "#########################################################################\n"
	sudo $INSTALL_COMMAND build-essential

	log_header
	echo  "************************* Build-essential Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s build-essential | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo -e "\n\n######################  Installing software-properties-common  #####################"
	echo -e "####################################################################################\n"
	sudo $INSTALL_COMMAND software-properties-common

	log_header
	echo  "************************* Software-properties-common Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s software-properties-common | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME

	echo -e "\n\n######################  Installing python-software-properties  #####################"
	echo -e "####################################################################################\n"
	sudo $INSTALL_COMMAND python-software-properties

	log_header
	echo  "************************* Python-software-properties Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s python-software-properties | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing General Compression tools
compression_tools_install(){
	echo -e "\n\n######################  Installing General Compression tools #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
}


# Installing curl
curl_install(){
	echo -e "\n\n######################  Installing Curl  ######################"
	echo -e "###############################################################\n"
	sudo $INSTALL_COMMAND curl

	log_header
	echo  "************************* Curl Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s curl | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Lynx
lynx_install(){
	echo -e "\n\n######################  Installing Lynx #####################"
	echo -e "#############################################################\n"
	sudo $INSTALL_COMMAND lynx

	log_header
	echo  "************************* Lynx Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s lynx | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Snap package manager
snap_install(){
	echo -e "\n\n######################  Installing SNAP #####################"
	echo -e "#############################################################\n"
	sudo $INSTALL_COMMAND snapd

	echo -e "\n\n######################  Adding Snap PATH to bashrc  #####################"
	echo -e "#########################################################################\n"
	echo -e 'export PATH="$PATH:/snap/bin"' >> ~/.bashrc

	log_header
	echo  "************************* Snap Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s snapd | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}





# "--------------------  Installing Microsoft TT core fonts  ---------------------"

# Installing Microsoft core fonts
msttcorefonts_install(){
	echo -e "\n\n######################  Installing Microsoft core fonts  #####################"
	echo -e "##############################################################################\n"
	sudo $INSTALL_COMMAND msttcorefonts
}




# "-----------------------  Installing Wallpapers  ------------------------"

# Installing Ubuntu Wallpapers
ubuntu_wallpapers_install(){
	echo -e "\n\n################  Installing Ubuntu Wallpapers ################"
	echo -e "##############################################################\n"

	sudo $INSTALL_COMMAND ubuntu-wallpapers-* edgy-wallpapers feisty-wallpapers gutsy-wallpapers
}


# Installing Mint Wallpapers
mint_wallpapers_install(){
	echo -e "\n\n##################  Installing Mint Wallpapers ################"
	echo -e "##############################################################\n"

	sudo $INSTALL_COMMAND mint-backgrounds-*
}




# "--------------------  Installing Browsers  ---------------------"

# Installing OPERA
opera_install(){
	echo -e "\n\n######################  Installing OPERA #####################"
	echo -e "##############################################################\n"

	echo -e "\n\n######################  OPERA apt repo  #####################\n"
	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
	sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
	update_repositories

	sudo $INSTALL_COMMAND opera-stable

	log_header
	echo  "************************* OPERA Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s opera-stable | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing CHROMIUM
chromium_install(){
	installation_cleanup
	echo -e "\n\n######################  Installing CHROMIUM #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND chromium-browser

	log_header
	echo  "************************* CHROMIUM-browser Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s chromium-browser | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing CHROME
chrome_install(){
	echo -e "\n\n######################  Installing CHROME #####################"
	echo -e "###############################################################\n"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb

	log_header
	echo  "************************* CHROME Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s google-chrome-stable | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}





# "----------------  Installing Multimedia tools  -----------------"

# Installing ubuntu-restricted-extras
ubuntu_restricted_extras_install(){
	echo -e "\n\n######################  Installing ubuntu-restricted-extras  #####################"
	echo -e "##################################################################################\n"
	sudo $INSTALL_COMMAND ubuntu-restricted-extras

	log_header
	echo  "************************* ubuntu-restricted-extras Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s ubuntu-restricted-extras | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing flashplugin-installer
flashplugin_install(){
	echo -e "\n\n######################  Installing flashplugin-installer  #####################"
	echo -e "###############################################################################\n"
	sudo $INSTALL_COMMAND flashplugin-installer

	log_header
	echo  "************************* flashplugin-installer Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s flashplugin-installer | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing DVD libdvdread4
libdvd_install(){
	echo -e "\n\n######################  Installing DVD libdvdread4  #####################"
	echo -e "#########################################################################\n"
	sudo $INSTALL_COMMAND libdvdcss2 libdvdread4 libdvdnav4
	sudo /usr/share/doc/libdvdread4/install-css.sh

	log_header
	echo  "************************* Libdvdcss2 Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s libdvdcss2 | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing VLC Player
vlc_install(){
	echo -e "\n\n######################  Installing VLC Player  #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND vlc

	log_header
	echo  "************************* VLC Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s vlc | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing SMPlayer
smplayer_install(){
	echo -e "\n\n######################  Installing SMPlayer  #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND smplayer

	log_header
	echo  "************************* SMPlayer Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s smplayer | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Audacious
audacious_install(){
	echo -e "\n\n#####################  Installing Audacious  #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND audacious
	sudo $INSTALL_COMMAND audacious-plugins

	log_header
	echo  "************************* Audacious Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s audacious | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Audacity
audacity_install(){
	echo -e "\n\n######################  Installing Audacity  #####################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND audacity
	sudo $INSTALL_COMMAND audacity-data

	log_header
	echo  "************************* Audacity Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s audacity | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}






# "------------------  Installing Tools & Soft  -------------------"

# Installing dconf
dconf_editor_install(){
	echo -e "\n\n######################  Installing dconf #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND dconf-cli dconf-editor

	log_header
	echo  "************************* DConf-editor Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s dconf-editor | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing KeePassX
keepassx_install(){
	echo -e "\n\n######################  Installing KeePassX #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND keepassx

	log_header
	echo  "************************* KeePassX Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s keepassx | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing DropBox
dropbox_install(){
	echo -e "\n\n######################  Installing DropBox #####################"
	echo -e "################################################################\n"
	sudo $INSTALL_COMMAND dropbox

	log_header
	echo  "************************* DropBox Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s dropbox | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Krusader with krename
krusader_install(){
	echo -e "\n\n######################  Installing Krusader #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND krusader
	sudo $INSTALL_COMMAND krename

	log_header
	echo  "************************* Krusader Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s krusader | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	sudo dpkg -s krename | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Midnight Commander Editor
midnightCommander_install(){
	echo -e "\n\n########################  Installing MC  #########################"
	echo -e "##################################################################\n"
	sudo $INSTALL_COMMAND mc

	log_header
	echo  "************************* Midnight Commander Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s mc | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Gparted with dependencies
gparted_install(){
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

	log_header
	echo  "************************* Gparted Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s gparted | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing HardInfo
hardinfo_install(){
	echo -e "\n\n######################  Installing HardInfo #####################"
	echo -e "#################################################################\n"
	sudo $INSTALL_COMMAND hardinfo

	log_header
	echo  "************************* HardInfo Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s hardinfo | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing ScreenFetch
screenFetch_install(){
	echo -e "\n\n######################  Installing ScreenFetch #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND screenfetch

	log_header
	echo  "************************* ScreenFetch Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s screenfetch | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Shutter
shutter_install(){
	echo -e "\n\n######################  Installing Shutter #####################"
	echo -e "################################################################\n"
	sudo $INSTALL_COMMAND shutter

	log_header
	echo  "************************* Shutter Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s shutter | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing SreenRuller
sreenRuller_install(){
	echo -e "\n\n######################  Installing SreenRuller #####################"
	echo -e "####################################################################\n"
	sudo $INSTALL_COMMAND screenruler

	log_header
	echo  "************************* SreenRuller Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s screenruler | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Konsole terminal
konsole_install(){
	echo -e "\n\n######################  Installing Konsole #####################"
	echo -e "################################################################\n"
	sudo $INSTALL_COMMAND konsole

	log_header
	echo  "************************* Konsole Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s konsole | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Terminator terminal
terminator_install(){
	echo -e "\n\n######################  Installing Terminator #####################"
	echo -e "###################################################################\n"
	sudo $INSTALL_COMMAND terminator

	log_header
	echo  "************************* Terminator Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s terminator | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing indicator-weather
indicator_weather_install(){
	echo -e "\n\n######################  Weather Indicator via PPA  #####################\n"
	sudo add-apt-repository -y ppa:kasra-mp/ubuntu-indicator-weather
	update_repositories

	echo -e "\n\n######################  Installing indicator-weather #####################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND indicator-weather

	log_header
	echo  "************************* Weather Indicator Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s indicator-weather | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing indicator-cpufre
indicator_cpufre_install(){
	echo -e "\n\n######################  Installing indicator-cpufreq #####################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND indicator-cpufreq

	log_header
	echo  "************************* CPUfreq-indicator Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s indicator-cpufreq | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Install Samba share
samba_install(){
	echo -e "\n\n######################  Installing Samba #####################"
	echo -e "##############################################################\n"
	sudo $INSTALL_COMMAND samba samba-common python-dnspython

	log_header
	echo  "************************* Samba Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s samba | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
	whereis samba >> $LOG_FILE_NAME

}

# Libre Office update
libreoffice_install(){
	echo -e "\n\n######################  LibreOffice PPA  #####################\n"
	sudo add-apt-repository -y ppa:libreoffice/ppa
	update_repositories
}

# Installing synapse
synapse_install(){
	echo -e "\n\n###########################  Installing Synapse ##########################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND synapse

	log_header
	echo  "************************* Synapse Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s synapse | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}



# Installing SpeedCrunch
speedcrunch_install(){
	echo -e "\n\n#########################  Installing SpeedCrunch ########################"
	echo -e "##########################################################################\n"
	sudo $INSTALL_COMMAND speedcrunch

	log_header
	echo  "************************* SpeedCrunch Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s speedcrunch | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Installing Geany editor
geany_install(){
	echo -e "\n\n######################  Installing Geany editor #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND geany

	log_header
	echo  "************************* Geany Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s geany | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}






# "--------------------  Installing Skype, Viber  ---------------------"

# Installing Skype
skype_install(){
	echo -e "\n\n#######################  Installing Skype #####################"
	echo -e "###############################################################\n"
	wget https://go.skype.com/skypeforlinux-64.deb -O skype_amd64.deb
	sudo dpkg -i skype_amd64.deb
	rm skype_amd64.deb

	log_header
	echo  "************************* Skype Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s skypeforlinux | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}


# Installing Viber
viber_install(){
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

	log_header
	echo  "************************* Viber Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s viber | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}






# "---------------------  YOUTUBE_DL setup  -----------------------"

# Installing YOUTUBE_DL
youtube_dl_install(){
	echo -e "\n\n######################  YOUTUBE_DL preconditions #####################\n"
	sudo $INSTALL_COMMAND ffmpeg rtmpdump
	mkdir $INSTALL_LOCATION/youtube_downloader

	echo -e "\n\n######################  Downloading YOUTUBE_DL #####################\n"
	sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O $INSTALL_LOCATION/youtube_downloader/youtube-dl
	sudo chmod 755 $INSTALL_LOCATION/youtube_downloader/youtube-dl
	sudo chown -R $LINUX_USER:$LINUX_USER $INSTALL_LOCATION/youtube_downloader
	cd $INSTALL_LOCATION/youtube_downloader

	log_header
	echo  "************************* YOUTUBE_DL Install status *************************" >> $LOG_FILE_NAME
	$INSTALL_LOCATION/youtube_downloader/youtube-dl --version >> $LOG_FILE_NAME
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
build_essentials_install
compression_tools_install
curl_install
lynx_install
snap_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------  Installing Microsoft TT core fonts  ---------------"
echo -e "----------------------------------------------------------------"
msttcorefonts_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installing Wallpapers  --------------------"
echo -e "----------------------------------------------------------------"
ubuntu_wallpapers_install
mint_wallpapers_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installing Browsers  ---------------------"
echo -e "----------------------------------------------------------------"
opera_install
chromium_install
chrome_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "----------------  Installing Multimedia tools  -----------------"
echo -e "----------------------------------------------------------------"
ubuntu_restricted_extras_install
flashplugin_install
libdvd_install
vlc_install
smplayer_install
audacious_install
audacity_install



echo -e "\n\n----------------------------------------------------------------"
echo -e "------------------  Installing Tools & Soft  -------------------"
echo -e "----------------------------------------------------------------"
dconf_editor_install
keepassx_install
dropbox_install
krusader_install
midnightCommander_install

gparted_install
hardinfo_install
screenFetch_install

shutter_install
sreenRuller_install
konsole_install
terminator_install
indicator_weather_install
indicator_cpufre_install

samba_install
libreoffice_install
synapse_install
speedcrunch_install
geany_install





echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup




echo -e "\n\n---------------------------------------------------------------------------"
echo -e "-----------------------  Installing Skype, Viber  -------------------------"
echo -e "---------------------------------------------------------------------------"
skype_install
viber_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "---------------------  YOUTUBE_DL setup  -----------------------"
echo -e "----------------------------------------------------------------"
youtube_dl_install




echo -e "\n\n----------------------------------------------------------------"
echo -e "--------------------  Installation cleanup  --------------------"
echo -e "----------------------------------------------------------------"
installation_cleanup




echo -e "\n\n----------------------------------------------------------------"
echo -e "-------------------  Installation FINISHED  --------------------"
echo -e "----------------------------------------------------------------\n"
