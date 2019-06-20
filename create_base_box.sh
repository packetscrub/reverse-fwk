# Create base box using virtualbox
# https://www.vagrantup.com/docs/virtualbox/boxes.html

# Get Virtualbox guest additions
# sudo apt-get install linux-headers-$(uname -r) build-essential dkms

# Install virtualbox guest additions for VBoxGuestAdditions_5.2.18.iso
VBOX_ED='5.2.18'
#wget http://download.virtualbox.org/virtualbox/$VBOX_ED/VBoxGuestAdditions_$VBOX_ED.iso
#sudo mkdir /media/VBoxGuestAdditions
#sudo mount -o loop,ro VBoxGuestAdditions_$VBOX_ED.iso /media/VBoxGuestAdditions
#sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
#rm VBoxGuestAdditions_$VBOX_ED.iso
#sudo umount /media/VBoxGuestAdditions
#sudo rmdir /media/VBoxGuestAddition

# Package the base box
vagrant package --base reversing-framework

