#!/bin/bash

# Enable autologin
groupadd -r autologin
gpasswd -a $USER autologin
sed -i "s/#autologin-user=/autologin-user=$USER/" /etc/lightdm/lightdm.conf
sed -i "s/#autologin-session=/autologin-session=i3" /etc/lightdm/lightdm.conf

# Enable touchpad tapping

sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/90-touchpad.conf 1> /dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
EndSection

EOF

# Update and install tools

dnf update -y

dnf install -y \
	neovim \
	rofi \
	alacritty \
	arandr \
	xset \
	xinput \

