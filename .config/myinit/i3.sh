#!/bin/bash

# Prerequisites
exec ./fedora.sh

LOGNAME=$(logname)
cd /home/$LOGNAME

# Update and install tools
dnf install -y \
	rofi \
	arandr \
	xset \
	xinput \
	picom \
	polybar \
	maim \
	xclip \
	light \
	playerctl

pip install autotiling

# Configs

# mkdir -p /etc/lightdm/lightdm.conf.d && tee /etc/lightdm/lightdm.conf.d/10-autologin.conf <<'EOF' 1>/dev/null
# [Seat:*]
# autologin-user=${LOGNAME}
# autologin-session=i3
# EOF
# groupadd -r autologin
# usermod -aG autologin $LOGNAME

mkdir -p /etc/X11/xorg.conf.d && tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "True"
EndSection
EOF
