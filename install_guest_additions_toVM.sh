#!/bin/bash

echo "==== Updating system ===="
sudo apt update -y

echo "==== Installing required packages ===="
sudo apt install -y build-essential dkms linux-headers-$(uname -r)

echo "==== Mounting Guest Additions CD ===="
sudo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom 2>/dev/null

if [ -f /mnt/cdrom/VBoxLinuxAdditions.run ]; then
    echo "==== Installing Guest Additions ===="
    sudo sh /mnt/cdrom/VBoxLinuxAdditions.run
else
    echo "ERROR: Guest Additions CD not found!"
    echo "Go to: Devices → Insert Guest Additions CD Image"
    exit 1
fi

echo "==== Adding user to vboxsf group ===="
sudo usermod -aG vboxsf $USER

echo "==== Cleaning up ===="
sudo umount /mnt/cdrom

echo "==== Installation completed ===="
echo "System will reboot in 5 seconds..."
sleep 5
sudo reboot