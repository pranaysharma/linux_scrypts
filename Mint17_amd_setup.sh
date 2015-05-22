#!/bin/bash
#Description:   Sequence of commands for a fresh installation of Linux(Mint 17 has been tested) on an AMD CPU 
#		machine with AMD GPU(R9-290)

#The MIT License (MIT)
#
#Copyright (c) 2014 TollMeQuick.com 
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
#Authors
#Pranay Sharma : pranaysharma(me@pranays.com)
#Website: 	 www.pranaysharma.in
#Linkedin: 	 www.linkedin.com/tw/pranaysharma
###### set the root password ######
sudo passwd root


####apt-fast installation #####
sudo apt-get -y install aria2 git
### install and initialize git #####
git config --global user.name "Pranay Sharma"
git config --global user.email "me@pranays.com"

###### change the user to root for installation of all the code below #####
sudo su

####apt-fast installation:https://github.com/ilikenwf/apt-fast #####
sudo apt-get update && sudo apt-get install -y apt-fast
#git clone https://github.com/ilikenwf/apt-fast.git
#cp apt-fast /usr/bin/
#chmod +x /usr/bin/apt-fast
#cp apt-fast.conf /etc
## doesnt work with adding the repo as 14.04 is not supported it seems
#sudo add-apt-repository -y ppa:apt-fast/stable

###########################################################

##### basic scrypt ####
sudo apt-fast update; sudo apt-fast upgrade -y


#### install linux headers and source ####
apt-fast update; apt-fast install -y build-essential linux-source linux-headers-`uname -r`;sudo apt-fast update && apt-fast upgrade -y && apt-fast install -y build-essential gcc make cmake mc subversion git bzip2 unzip xorg libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm libtool libboost-all-dev libxss-dev libdbus-glib-1-dev openjdk-7-jre freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj ccmake cabextract file-roller libqt4-dbus libqt4-network libqt4-xml libasound2 python-dev python-pip
### Download AMD catylist drivers ###
#unpack and install prerequisites
#Install the prerequisites. Note: '-y' is helpful for unattended installation i.e you agree to download and
#install all these packages
sudo apt-fast install -y build-essential cdbs dh-make dkms execstack dh-modaliases linux-headers-generic fakeroot libqtgui4 lib32gcc1
#for 64 bit machines
sudo apt-fast install -y ia32-libs
#unzip 
unzip amd-catalyst*
#change the directory
cd fglrx*
## change UBUNTU RARING TO THE CORRECT VERSION
sudo sh *.run --buildpkg Ubuntu/trusty
##install the AMD drivers
sudo dpkg -i fglrx*.deb
# See if all your GPU's are listed correctly
aticonfig --lsa
#Initialize all the devices
sudo aticonfig --initial -f --adapter=all
#reboot
sudo reboot

##Install VAAPI support for video acceleration : http://www.webupd8.org/2012/11/install-mplayer-with-va-api-hardware.html
#for AMD GPU
sudo apt-fast -y install xvba-va-driver  
#For Intel GPu 
#sudo apt-fast install i965-va-driver

#[crashes firefox]UNTESTED :: How to enable VDPAU acceleration for accelerated Flash video  http://www.reddit.com/r/Ubuntu/comments/1wpavp/how_to_enable_vdpau_acceleration_for_accelerated/
##[Github source]
###[IMP]http://www.webupd8.org/2013/09/adobe-flash-player-hardware.html
#sudo add-apt-repository ppa:nilarimogard/webupd8
#sudo apt-fast update
#sudo apt-fast install libvdpau-va-gl1
#sudo sh -c "echo 'export VDPAU_DRIVER=va_gl' >> /etc/profile"
#sudo mkdir /etc/adobe
#sudo echo -e "EnableLinuxHWVideoDecode = 1\nOverrideGPUValidation = 1" | sudo tee /etc/adobe/mms.cfg

#####Python related #####
#install pip and python-dev
sudo apt-fast install -y python-dev python-pip

#install supervisord
sudo apt-fast -y install supervisor

#install virtual env
sudo pip install virtualenv
#virtual env wrapper 
sudo pip install virtualenvwrapper
	#setup virtualenv
	test -d ~/$VIRTUAL_ENV_FILE_NAME || mkdir ~/$VIRTUAL_ENV_FILE_NAME 
	#check if .bashrc is present first
	test -d $BASHRC_FILE_NAME || touch $BASHRC_FILE_NAME
	echo "#setup virtual env" >> ~/.bashrc
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
	#run the virtual env activation script when the shell starts.
	#do which virtualenvwrapper_lazy.sh to find the below path
	echo "source /usr/local/bin/virtualenvwrapper_lazy.sh" >> ~/.bashrc
source ~/.bashrc

#### install Chrome ######
sudo apt-fast install -y libxss1
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

##### Install compression/decompression tools ####
sudo apt-fast install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller


##### essential for programming
sudo apt-fast update && apt-fast upgrade -y && apt-fast install -y gcc make cmake mc  git bzip2 unzip xorg  libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm libtool libboost-all-dev libxss-dev libdbus-glib-1-dev openjdk-7-jre freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev terminator


##### Skype #####
sudo apt-fast install -y libqt4-dbus libqt4-network libqt4-xml libasound2 && wget http://www.skype.com/go/getskype-linux-beta-ubuntu-64
sudo dpkg -i getskype-* && sudo apt-fast -f install
sudo apt-fast install -y sni-qt:i386
#### FTP and server related ####
sudo apt-fast install -y filezilla filezilla-common

