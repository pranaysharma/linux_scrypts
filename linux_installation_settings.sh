#!/bin/bash
#The MIT License (MIT)
#
#Copyright (c) 2014 pranaysharma(me@pranays.com)
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

###### set the root password ######
sudo passwd root

###### change the user to root for installation of all the code below  #####
sudo su

##### basic scrypt ####
sudo apt-get update; sudo apt-get upgrade -y

### install and initialize git #####
git config --global user.name "Pranay Sharma"
git config --global user.email "me@pranays.com"

####apt-fast installation #####
sudo apt-get -y install aria2 git
git clone https://github.com/ilikenwf/apt-fast.git
cd apt-fast
cp apt-fast /usr/bin/
chmod +x /usr/bin/apt-fast
cp apt-fast.conf /etc
## doesnt work with adding the repo as 14.04 is not supported it seems
#sudo add-apt-repository -y ppa:apt-fast/stable
#sudo apt-get update && sudo apt-get install -y apt-fast
###########################################################

###### basic bash setup. Source startup-engineering class https://d396qusza40orc.cloudfront.net/startup/lecture_slides%2Flecture4b-developer-environment.pdf
git clone https://github.com/startup-class/setup.git
./setup/setup.sh

#### broadcom wireless & fan control #####
sudo apt-get install -y bcmwl-kernel-source macfanctld

#### install linux headers and source ####
apt-get install build-essential linux-source linux-headers-`uname -r`

#### disable online search for Dash ######
wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash

#### disable overlay scrollbars ######
gsettings set com.canonical.desktop.interface scrollbar-mode normal

#### Enable overlay scrollbars ######
#gsettings reset com.canonical.desktop.interface scrollbar-mode

#### install nemo file manager:http://www.webupd8.org/2013/10/install-nemo-with-unity-patches-and.html #####
sudo add-apt-repository -y ppa:webupd8team/nemo
sudo apt-get update
sudo apt-get install -y nemo nemo-fileroller
   ### To prevent Nautilus from handling the desktop icons (and use
   ### Nemo instead), use the commands below:
	sudo apt-get install -y dconf-tools
	gsettings set org.gnome.desktop.background show-desktop-icons false
   ### Set Nemo as the default file manager (replacing Nautilus)
	xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search


#### Enable Firewall #####
sudo apt-get install -y gufw

#### Enable Locally Integrated Menus & Scale Title + Menus #####


#### install Chrome ######
sudo apt-get install -y libxss1
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

#### TLP/Powersaving ####
sudo add-apt-repository -y ppa:linrunner/tlp && sudo apt-get update && sudo apt-get install tlp tlp-rdw
nano /etc/default/tlp

#Change the following values.
#DISK_IDLE_SECS_ON_AC=0
#DISK_IDLE_SECS_ON_BAT=2
#MAX_LOST_WORK_SECS_ON_BAT=60
#CPU_SCALING_GOVERNOR_ON_BAT=powersave
#CPU_BOOST_ON_BAT=0
#DISK_APM_LEVEL_ON_BAT="1 1"
#RUNTIME_PM_ALL=1
#RESTORE_DEVICE_STATE_ON_STARTUP=1

#### Shutdown, Restart, options from Dash  ####
sudo add-apt-repository -y ppa:atareao/atareao && sudo apt-get update && sudo apt-get install power-commands

#####   Auto control keyboard brightness #####
#      http://pof.eslack.org/2011/12/04/lightum-auto-adjust-keyboard-brightness-on-macbook/
sudo add-apt-repository ppa:poliva/lightum-mba && sudo apt-get update && sudo apt-get install lightum

#####   Auto screen  brightness   http://www.matrix44.net/blog/?p=963


##### essential for programming
sudo apt-get update && apt-get upgrade -y && apt-get install -y build-essential gcc make cmake mc python-dev subversion git bzip2 unzip xorg python2.7 python-numpy python-scipy libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm libtool libboost-all-dev python-setuptools libxss-dev libdbus-glib-1-dev openjdk-7-jre freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev

##### initial setup files
sudo apt-get install -y terminator screen flashplugin-installer ubuntu-restricted-extras gstreamer0.10-plugins-ugly libxine1-ffmpeg gxine mencoder libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra libxine1-ffmpeg gxine mencoder mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 ffmpeg totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 libjpeg-progs flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview flac libmpeg3-1 mpeg3-utils mpegdemux liba52-0.7.4-dev libquicktime2 gedit-plugins gedit-developer-plugins gparted compizconfig-settings-manager

##### Right click for open in terminal #####
sudo apt-get install -y nautilus-open-terminal

##### Skype #####
sudo apt-fast install -y libqt4-dbus libqt4-network libqt4-xml libasound2 && wget http://www.skype.com/go/getskype-linux-beta-ubuntu-64
sudo dpkg -i getskype-* && sudo apt-get -f install
sudo apt-fast install -y sni-qt:i386

#### FTP and server related ####
sudo apt-get install -y filezilla filezilla-common

#### image editing #####


##### Enable DVD Playback
sudo /usr/share/doc/libdvdread4/install-css.sh

##### Enable H.264 support for Firefox #####
sudo add-apt-repository -y ppa:mc3man/trusty-media
sudo apt-get update
sudo apt-get install -y gstreamer0.10-ffmpeg

##### Install compression/decompression tools ####
sudo apt-get install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller

##### install Pipelight(silverlight alternative) #####
sudo add-apt-repository -y ppa:pipelight/stable
sudo apt-get update
sudo apt-get install -y pipelight
sudo pipelight-plugin --update
sudo pipelight-plugin --enable silverlight
sudo pipelight-plugin --enable flash

#### Multimedia Players ######
sudo add-apt-repository -y ppa:n-muench/vlc
sudo apt-get update
sudo apt-get install -y vlc mplayer

#### Install Banshee player for mpr ####
sudo apt-fast install -y banshee

##### Other Todo ######
#1. Enable Workspaces and desktop launch icon:http://askubuntu.com/questions/260510/how-do-i-turn-on-workspaces-why-do-i-only-have-one-workspace-since-13-04/287408#287408


##### Disable Function key for multimedia(set to 1 to reenable) #####
sudo su
sudo echo "echo 2 > /sys/module/hid_apple/parameters/fnmode" >>  /etc/init.d/rc.local &


##### reset Unity ######
#sudo apt-get install -y dconf-tools
#dconf reset -f /org/compiz/
#setsid unity
#unity --reset-icons


cv+cuda  http://sn0v.wordpress.com/2012/05/11/installing-cuda-on-ubuntu-12-04/
cv       http://karytech.blogspot.tw/2012/05/opencv-24-on-ubuntu-1204.html
##### opencv dependencies ##########
sudo apt-get install -y build-essential checkinstall cmake pkg-config yasm
##related to image i/o
sudo apt-get install -y libtiff4-dev libjpeg-dev libjasper-dev
## related to video i/o
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev

### related to python
sudo apt-get install -y python-dev python-numpy
#### 3rd party libraries
sudo apt-get install -y libtbb-dev
####GUI
sudo apt-get install -y libqt4-dev libgtk2.0-dev



##setting up aliases
	#for the workspace
	#workspace=/media/pranay/6A88-A62A/workspace
	#alias workspace="cd $workspace"



