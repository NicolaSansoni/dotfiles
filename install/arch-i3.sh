#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root." >&2
	exit 1
fi

echo "Username: "
read USER

# user creation
if id $USER >/dev/null 2>&1; then
	echo "Found user $USER"
else
	useradd -m $USER
	passwd $USER
fi

# update system
pacman -Syu --noconfirm

# shell utils
pacman -S --noconfirm	\
	zsh	\
	fd	\
	bat	\
	neovim	\
	tmux	\
	ripgrep	\
	jq	\
	fzf	\
	tldr	\
	which	\
	parallel	\

# sysadmin
pacman -Rdd --noconfirm	iptables	# necessary as it conflicts with iptables-nft
pacman -S --noconfirm	\
	sudo	\
	dnsmasq	\
	qemu-full	\
	libvirt	\
	virt-manager	\
	iptables-nft	\
	zip	\
	unzip	\
	go	\
	npm	\
	rust	\
	python	\
	python-pipx	\
	base-devel	\
	cmake	\
	openssh	\
	xdg-user-dirs	\

# desktop
pacman -S --noconfirm	\
	xorg	\
	arandr	\
	lightdm	\
	lightdm-gtk-greeter	\
	i3-wm	\
	rofi	\
	picom	\
	polybar	\
	maim	\
	xclip	\
	playerctl	\
	thunar	\
	feh	\
	alacritty	\
	ttf-cascadia-code-nerd	\
	ufw	\
	chromium	\

# audio
pacman -S --noconfirm	\
	pipewire	\
	pipewire-audio	\
	pipewire-alsa	\
	pipewire-pulse	\
	pipewire-jack	\
	wireplumber	\
	pavucontrol	\

# user config
gpasswd -a $USER wheel
chsh -s $(which zsh) $USER
sudo -u $USER xdg-user-dirs-update

# sudo config
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10-wheel

# DNS config
rm /etc/resolv.conf
ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# AUR
useradd -m -s /usr/bin/nologin aurhelper
echo "aurhelper ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-aurhelper

sudo -u aurhelper git clone https://aur.archlinux.org/yay-bin.git /home/aurhelper/yay
cd /home/aurhelper/yay
sudo -u aurhelper makepkg -si --noconfirm
sudo -u aurhelper yay -Y --gendb
cd

sudo -u aurhelper yay -S --noconfirm \
	oh-my-zsh-git	\
	spotify	\

rm /etc/sudoers.d/99-aurhelper
killall -u aurhelper
userdel -r aurhelper

# xorg config
mkdir -p /etc/X11/xorg.conf.d && tee /etc/X11/xorg.conf.d/15-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "True"
EndSection
EOF

mkdir -p /etc/X11/xorg.conf.d && tee /etc/X11/xorg.conf.d/10-mouse.conf <<'EOF' 1>/dev/null
Section "InputClass"
  Identifier "mouse"
  MatchIsPointer "yes"
  MatchDriver "libinput"
  Option "AccelProfile" "flat"
  Option "AccelSpeed" "0"
EndSection
EOF

# systemd enable services
systemctl enable lightdm
systemctl enable libvirtd
systemctl enable nftables
systemctl --global enable wireplumber

sudo -u $USER -- pipx install autotiling

echo "Remember to install microcode (https://wiki.archlinux.org/title/Microcode)"
echo "Remember to install graphics drivers (https://wiki.archlinux.org/title/Xorg#Driver_installation)"
echo "Remember to lock root (https://wiki.archlinux.org/title/Sudo#Disable_root_login)"

echo "Please reboot"
