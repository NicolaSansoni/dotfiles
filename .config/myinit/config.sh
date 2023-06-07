#!/bin/bash

LOGNAME=$(logname)

groupadd -r autologin
usermod -aG autologin $LOGNAME

groupadd docker
usermod -aG docker $LOGNAME

sed -i "s/#autologin-user=/autologin-user=$LOGNAME/" /etc/lightdm/lightdm.conf
sed -i "s/#autologin-session=/autologin-session=i3/" /etc/lightdm/lightdm.conf

sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "True"
EndSection

EOF
