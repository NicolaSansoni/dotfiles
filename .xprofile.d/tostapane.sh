#!/bin/bash

# X configuration
xrandr --dpi 192 \
	--output HDMI-0 -s 1920x1080 --scale 2x2 --rate 60.00 --primary \
	--output DP-2 -s 3840x2160 --rate 60.00 --left-of HDMI-0

