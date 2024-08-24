#!/bin/bash

# X configuration
xrandr --dpi 192 \
	--output HDMI-0 -s 1920x1080 --scale 2x2 --rate 60.00 --primary \
	--output DP-2 -s 3840x2160 --rate 60.00 --left-of HDMI-0

tee $HOME/.Xresources <<'EOF' 1>/dev/null
Xft.dpi: 192
Xft.autohint: 0
Xft.lcdfilter: lcddefault
Xft.hintstyle: hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
EOF

