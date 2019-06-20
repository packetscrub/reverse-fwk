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

# Get kvm prerequisite packages
# sudo apt update -y
# sudo apt install -y qemu-kvm \
#                     libvirt-bin \
#                     libvirt-doc

# Install machine
echo "Creating VM $VM_NAME from $ISO_FILE"
virt-install \
    --connect=qemu:///system \
    --name=$VM_NAME \
    --vcpus=1 \
    --memory=1024 \
    --boot=cdrom \
    --disk=$PROJ_DIR/$VM_NAME.qcow2,size=30,bus=virtio \
    --os-type=linux \
    --os-variant=ubuntu18.04 \
    --graphics=none \
    --noautoconsole \
    --hvm \
    --extra-args="ks=file:/ks.cfg console=tty0 console=ttyS0,115200 serial" \
    --initrd-inject=$PROJ_DIR/ks.cfg \
    --location=$ISO_FILE \
    --debug
