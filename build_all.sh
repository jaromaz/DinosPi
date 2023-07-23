#!/bin/bash
# --------------------------------------------------------
# DinosPi / 2023
# --------------------------------------------------------
# It is a small project that allows running full-screen
# versions of Apple's Mac OS 7, 8 and 9 with audio,
# active online connection and modem emulation under
# Raspberry Pi. 
# --------------------------------------------------------
# Author: Jaroslaw Mazurkiewicz  /  jaromaz
# www: https://jm.iq.pl  e-mail: jm at iq.pl
# --------------------------------------------------------

source assets/func.sh
usercheck
logo
updateinfo
installinfo
for APP in apple1 apple2 altair-imsai; do
    ( cd ${APP} && ./${APP}.sh )
done
echo '** all done'

