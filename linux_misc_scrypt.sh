#Description:  
#This file has generic commands which are required frequently during linux system setup or working

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

######################### Swap    ########################
##Swap on LVS(similar method for all systems. Important is to add the file in fstab and then run 'swapon -a'.
  #Run 'swapoff -a' to turn of all the swap spaces mentioned in fstab 
sudo  lvcreate -L 8G -C y -n lv_swap vgmain
sudo mkswap /dev/mapper/vgmain-lv_swap
#edit Fstab
sudo nano /etc/fstab
##add the following line at the end 
/dev/mapper/vgmain-lv_swap none swap sw 0 0
##enable the swaps listed in fstab
sudo swapon -a
##check with command
free -m
#mount all the drives in /etc/fstab
mount -a
############################Fstab related resources #################
https://wiki.archlinux.org/index.php/fstab

###########################Networking related commands ###############
#Ethernet interface
sudo ip link set eth0 down
sudo ip link set eth0 up
#Wireless interface
sudo ip link set wlan0 down
sudo ip link set wlan0 up


#In terminal see changes to a file(n mentions the period of 1 second)
#watch -n 1 file name
#eg for pandaboard 
watch -d -n 1 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq 



##############################Screen###############################  
#create a detached screen session
screen -dmS s0
#attach to s0 session
screen -r s0


#############################LVM ##################################
#useful LVM related links online: 
#1.For Fresh Installation:  http://swaeku.github.io/blog/2013/03/25/install-ubuntu-desktop-on-lvm-partitions/
#2.For generic use:        http://www.linuxuser.co.uk/features/resize-your-disks-on-the-fly-with-lvm 
#extend lvm(vg_data-lvhome) by 10G
sudo lvextend -L+10G /dev/mapper/vg_data-lvhome
#now the filesystem has to be resized
sudo resize2fs /dev/mapper/vg_data-lvhome 

