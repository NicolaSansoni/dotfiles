#!/bin/bash

# Prerequisites
exec ./fedora.sh

LOGNAME=$(logname)
cd /home/$LOGNAME

# Update and install tools
dnf install -y \
	sway \
	rofi-wayland \
	wdisplays \
	waybar \
	grim \
	slurp \
	wl-clipboard \
	light \
	playerctl

pip install autotiling

# Configs
mkdir -p /usr/share/wayland-sessions && tee /usr/share/wayland-sessions/nvsway.desktop <<'EOF' 1>/dev/null
[Desktop Entry]
Name=Sway Nvidia
Comment=An i3-compatible Wayland compositor
Exec=nvsway
Type=Application
EOF

mkdir -p /usr/bin && tee /usr/bin/nvsway <<'EOF' 1>/dev/null
#!/bin/bash

export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER=vulkan
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export GBM_BACKEND=nvidia-drm
export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export XWAYLAND_NO_GLAMOR=1

exec sway --unsupported-gpu
EOF
