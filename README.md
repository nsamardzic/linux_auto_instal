# Linux Auto Install script
This is the bash auto install script that I use for configuring Linux OS after initial install.

<br/><br/>

## Scripts Auto Install
Following script is inspired by this contributor:
 - [erikdubois/Ultimate-Linux-Mint-18.3-Cinnamon](https://github.com/erikdubois/Ultimate-Linux-Mint-18.3-Cinnamon)

 #### User interaction
 User interaction is needed in two steps of initial script execution (within first several minutes):
 - msttcorefonts install
 - Java JDK install

#### This script automation refers to:
- automatic install of packages that you select
- configuration of some environment parameters (.bashrc)
- script local variables to help with script customization

#### Testing
This script is tested in following distributions:
- ubuntu 18.04 x64
- mint 18.04 x64


Fell free to configure this script as you see fit, and to suggest further improvements and modification. 

<br/><br/>

## Disclamer
Prior to trying and running the script I suggest that you consult the script configuration.<br/>
Review the software included & configuration and check if it fit your needs.

By default, this script will do the following:
- auto install additional repos
- auto install software to your local machine
- edit the `.bashrc` file


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

5. As default, following repos are auto-added to sources:
- JAVA PPA - `sudo add-apt-repository -y ppa:webupd8team/java`

- Brackets PPA - `sudo add-apt-repository -y ppa:webupd8team/brackets`

- Atom PPA - `sudo add-apt-repository -y ppa:webupd8team/atom`

- LibreOffice PPA
`sudo add-apt-repository -y ppa:libreoffice/ppa`

- Weather Indicator via PPA - `sudo add-apt-repository -y ppa:kasra-mp/ubuntu-indicator-weather`  

- DOCKER apt repo
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
```


## ToDo List

- Integrate separate logging to standard and error output (stderr to stdout, tee)
- Integrate [Dialog](http://linuxcommand.org/lc3_adv_dialog.php) for selecting distribution type
- Make further improvements to make script more adaptable to other distros/package managers.
- Follow up on given feedback :)
