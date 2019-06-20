# Create VirtualBox VM using an Ubuntu server ISO
# https://www.linuxtechi.com/manage-virtualbox-virtual-machines-command-line/
PROJ_DIR="$(pwd)"
ISO_PATH="$PROJ_DIR/iso"
VM_NAME="reversing-framework"

# Check if iso exists already, otherwise download it
if [ -z "$(ls -A $ISO_PATH)" ]; then
    echo "No ISO found, downloading ubuntu-18.04 server image"
    wget -P $ISO_PATH http://releases.ubuntu.com/18.04.2/ubuntu-18.04.2-live-server-amd64.iso
else
    echo "Found ISO $(basename $(ls $ISO_PATH/*))"
fi

ISO_FILE="$ISO_PATH/ubuntu-18.04.2-live-server-amd64.iso"
VBOX_PATH="$PROJ_DIR/$VM_NAME/$VM_NAME.vdi"

# VBox create VM
VBoxManage createvm --name $VM_NAME --ostype Ubuntu_64 --register
# need to create network here
VBoxManage modifyvm $VM_NAME --memory 1024
VBoxManage createhd --filename $VBOX_PATH --size 10000 --format VDI
VBoxManage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VBOX_PATH
VBoxManage storagectl $VM_NAME --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $ISO_FILE

# Start VM
VBoxManage startvm $VM_NAME
