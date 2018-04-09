#!/bin/bash
# Purpose of the script is to reduce the disk size of the VM before we use 'packer' to create of vagrant box
# This script is for now meant for SLES11

# Remove unneeded software packages
zypper --non-interactive remove wireless-tools

# Clean up the zypper cache
zypper clean --all

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Remove bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout root
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`; 
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

if mount | grep -q "/boot" ; then
    # Whiteout /boot
    count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
    let count--
    dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
    rm /boot/whitespace;
fi

swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
if [ "$swappart" != "" ]; then
  swapoff $swappart;
  dd if=/dev/zero of=$swappart;
  mkswap $swappart;
  swapon $swappart;
fi

# to avoid issues with MAC addresses on the LAN interfaces
[[ -f /etc/udev/rules.d/70-persistent-net.rules ]] & rm -f /etc/udev/rules.d/70-persistent-net.rules
