#!/bin/bash

LOGNAME=$(logname)
cd /home/$LOGNAME

# Update and install tools
dnf install -y \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y \
	akmod-nvidia \
	xord-x11-drv-nvidia-cuda
