#!/bin/bash

LOGNAME=$(logname)

# Enable autologin
groupadd -r autologin
gpasswd -a $LOGNAME autologin
sed -i "s/#autologin-user=/autologin-user=\"$LOGNAME\"/" /etc/lightdm/lightdm.conf
sed -i "s/#autologin-session=/autologin-session=\"i3\"/" /etc/lightdm/lightdm.conf

# Enable touchpad tapping

sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "True"
EndSection

EOF

# Update and install tools

dnf install -y \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf update -y

dnf group install -y "C Development Tools and Libraries" "Development Tools"

dnf install -y \
	neovim \
	rofi \
	alacritty \
	arandr \
	xset \
	xinput \
	ripgrep \
	flatpak \
	picom \
	polybar \
	zstd \
	maim \
	xclip

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

git clone https://github.com/asdf-vm/asdf.git /home/$LOGNAME/.asdf

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
groupadd docker
usermod -aG docker $LOGNAME
