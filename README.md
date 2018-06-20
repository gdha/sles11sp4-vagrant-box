# sles11sp4-vagrant-box

## Software requirements

You need to have the following software tools installed before you can create a vagrant box:
- vagrant
- VirtualBox
- [packer](github.com/hashicorp/packer)
- Download the ISO image from SLES (user subscription is required)

## Create SLES11 SP4 VM with VirtualBox

- Launch the VirtualBox application and create a VM with the SLES11 ISO attached and do a basic installation
- Only LAN interface is required at this stage
- Create the account vagrant/vagrant
- Attach the required software channels from SLES to be able to patch and install additional software
- Install perl, ansible, python

## The creation of the vagrant SLES11 SP4 box
