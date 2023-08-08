#!/bin/bash

LOGNAME=$(logname)

groupadd -r autologin
usermod -aG autologin $LOGNAME

groupadd docker
usermod -aG docker $LOGNAME

sudo mkdir -p /etc/lightdm/lightdm.conf.d && sudo printf "\
[Seat:*]
autologin-user=${LOGNAME}
autologin-session=i3
" >/etc/lightdm/lightdm.conf.d/10-autologin.conf

sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "True"
EndSection

EOF
