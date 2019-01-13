# Linux Auto Install script


This is the bash auto install script that I use for configuring Linux OS after initial install.

Fell free to configure this script as you see fit and to suggest further improvements and modification.


<br/><br/>

## Scripts Auto Install
Following script is inspired by this contributor:

 - [erikdubois/Ultimate-Linux-Mint-18.3-Cinnamon](https://github.com/erikdubois/Ultimate-Linux-Mint-18.3-Cinnamon)
<br/>

#### User interaction
 User interaction is needed in 3 steps of initial script execution (within first several minutes):
 
 - Java JDK install
 - msttcorefonts install
 - Opera browser

<br/>

#### This script automation refers to:

- automatic install of packages that you select
- configuration of some environment parameters (.bashrc)
- script local variables to help with script customization

<br/>

#### Testing
This script is tested in following distributions:

- ubuntu 18.04 x64
- mint (mate & cinnammon) 18.04 x64




<br/><br/>


## Usage

The script contains install scripts encapsulated in functions:
```
# Installing Geany editor
geany_install(){
	echo -e "\n\n######################  Installing Geany editor #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND geany

	log_header
	echo  "************************* Geany Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s geany | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

# Calling the install function for Geany
geany_install

```

<br/>

### Select or Deselect software for installation

You can select/deselect which software you want to install with commenting out the function call or simply deleting it.

Example of selecting Geany package for install:
```
# Calling the install function for Geany
geany_install
```
<br/>
Example of DESELECTING Geany package for install:

```
# Calling the install function for Geany
# geany_install
```




<br/><br/>




## Configuration


1. Username of the user that is performing the installation

```
LINUX_USER=ime
```

2. Target folder name (absolute path) to which you want your tar.gz type of apps to be installed/unpacked.<br/>
This script assumes that this location is within "HOME" folder

```
INSTALL_LOCATION=~/Applications
```

3. Defines which package manager/install command/switches for the package installation.<br/>
This variable is introduced to ease trasformation to other package managers.

```
INSTALL_COMMAND=apt-get install -y
```

4. This conditional checks if theres existing INSTALL_LOCATION folder, and if not it creates it.<br/>
Also, folder is chown to home user privilages - user is defined in LINUX_USER variable

```
if [ ! -d "$INSTALL_LOCATION" ];
then
	mkdir -p $INSTALL_LOCATION
fi

chown $LINUX_USER $INSTALL_LOCATION
```

5. Defines log file name for implemented loging per function call.<br/>

```
LOG_FILE_NAME=Install_log.txt
```



<br/><br/>

## Logging


Certain (basic) level of logging is implemented within function call per package.
By default, log output is saved to log file, with log file name defined in ```LOG_FILE_NAME``` variable.
<br/>
Function ```log_header```  is also part of  log output, and serves for:

- generating install timestamp & datestamp
- cosmetic - indentation purpose


```
# Installing Geany editor
geany_install(){
	echo -e "\n\n######################  Installing Geany editor #####################"
	echo -e "#####################################################################\n"
	sudo $INSTALL_COMMAND geany

	log_header
	echo  "************************* Geany Install status *************************" >> $LOG_FILE_NAME
	sudo dpkg -s geany | grep -Ei 'Package|Version|Status' >> $LOG_FILE_NAME
}

```
<br/><br/>


## Disclamer
Prior to trying and running the script I suggest that you consult the script configuration.<br/>
Review the software included & configuration and check if it fit and to your preferences.

By default, this script will do the following:
- auto install additional repos, required by software that you selected
- auto install software to your local machine
- edit the `.bashrc` file




<br/><br/>
## ToDo List


- Integrate [Dialog](http://linuxcommand.org/lc3_adv_dialog.php) for selecting distribution type
- Make further improvements to make script more adaptable to other distros/package managers.
- Follow up on given feedback :)
