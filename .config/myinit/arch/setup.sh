#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root." >&2
	exit 1
fi

DIR=$(dirname $0 | xargs realpath)
LOGNAME=$(logname)

cd /home/$LOGNAME

pacman -Syu

pacman -S --noconfirm libvirt virt-manager

systemctl enable libvirtd
systemctl start libvirtd

usermod -aG libvirt $LOGNAME

pacman -R --noconfirm xterm

pacman -S --noconfirm \
	neovim \
	alacritty \
	ripgrep \
	zstd \
	jq \
	fzf \
	tldr \
	tk \
	sqlite \
	libffi \
	bzip2 \
	ncurses \
	readline \
	parallel \
	ttf-cascadia-code-nerd

# Asdf
sudo -u $LOGNAME -- bash <<'EOF'
cd 
if ! [ -f .asdf/bin/asdf ]; then
	git clone https://github.com/asdf-vm/asdf.git .asdf
fi

source .asdf/asdf.sh

for P in $(cat .tool-versions | awk '{print $1}'); do
	asdf plugin-add $P
done

asdf install

for P in $(cat .tool-versions | awk '{print $1}'); do
	asdf reshim $P
done
EOF
