#Generated by Kickstart Configurator
#platform=x86

#System language
lang en_US
#Language modules to install
langsupport en_US
#System keyboard
keyboard us
#System mouse
mouse
#System timezone
timezone America/Los_Angeles
#Root password
rootpw --disabled
#Initial user - example user/pw with md5hashed pw. Change as you see fit!
user reverse --fullname "ubuntu" --iscrypted --password "baf53d53046272cae4ea9609aebb8496"
#Reboot after installation
reboot
#Use text mode install
text
#Install OS instead of upgrade
install
#Use CDROM installation media
cdrom
#System bootloader configuration
bootloader --location=mbr 
#Clear the Master Boot Record
zerombr yes
#Partition clearing information
clearpart --all --initlabel 
# Disk partitioning information
part / --fstype ext4 --size 3700 --grow
part swap --size 200 
#System authorization infomation
auth  --useshadow  --enablemd5 
#Network information
network --bootproto=dhcp --device=eth0
#Firewall configuration
firewall --enabled --ssh 
#Do not configure the X Window System
skipx

# Add your custom post installation script here
%post --interpreter=/bin/bash
echo ### updating and installing packages
apt-get update
apt-get -y upgrade
apt-get install -y openssh-server vim python git

echo ### Enable serial console so virsh can connect to the console
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service

