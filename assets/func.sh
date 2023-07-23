#!/bin/bash
# --------------------------------------------------------
# DinosPi
# --------------------------------------------------------
# It is a small project that allows running full-screen
# versions of Apple 1, 2, Altair, IMSAI on Raspberry Pi. 
# --------------------------------------------------------
# Author: Jaroslaw Mazurkiewicz  /  jaromaz
# www: https://jm.iq.pl  e-mail: jm at iq.pl
# --------------------------------------------------------
# DinosPi functions
# --------------------------------------------------------

VERSION="1.1"
BASE_DIR="/usr/share/dinospi"
SRC_DIR="${BASE_DIR}/src"
HDD_IMAGES="https://homer-retro.space/appfiles"
ASOFT="${HDD_IMAGES}/as/asoft.tar.gz"


function updateinfo {
parent=$(cat /proc/$PPID/comm)
if [ "$parent" != "build_all.sh" ]; then
cat <<EOF

* WARNING: 
To install this software, you must first update and reboot your
system. If you want to perform these steps now, then press "y" key.
If your system is up to date and rebooted, then press any other
key or wait 30 seconds.

EOF

read -t 30 -n 1 -s updinfo
[ "$updinfo" = "y" ] && sudo apt update && sudo apt upgrade -y && sudo reboot && exit
fi
}


function mtimer {
for i in {10..1}; do printf "$i ... "; sleep 1; done
echo
}

function installinfo {
cat << EOF
* INFO: 
The build and installation process will take a few tens of minutes.

EOF
mtimer
}


function net_error {
    echo
    echo "***********"
    echo
    echo "Error - can't download: $1"
    echo "Check your Internet connection and try again later."
    echo
    echo "If you still feel its a bug, then please create an issue here:"
    echo "https://github.com/jaromaz/DinosPi/issues/new"
    echo
    parent=$(cat /proc/$PPID/comm)
    [ "$parent" == "build_all.sh" ] && killall -q build_all.sh
    exit
}


function usercheck {
  [ $USER == "root" ] && echo 'Run this script as your standard user.' && exit
}



function Base_dir {
   [ -d ${BASE_DIR} ] || ( sudo mkdir -p ${BASE_DIR} && sudo chown $USER:$USER ${BASE_DIR} )
}


function Src_dir {
   [ -d ${SRC_DIR} ] || ( sudo mkdir -p ${SRC_DIR} && sudo chown $USER:$USER ${SRC_DIR} )
}



function logo {


clear; printf "\e[96m"; echo '

 ____                    ____  _ 
|  _ \(_)_ __   ___  ___|  _ \(_)
| | | | |  _ \ / _ \/ __| |_) | |
| |_| | | | | | (_) \__ \  __/| |
|____/|_|_| |_|\___/|___/_|   |_|


';

    printf "\e[93m"
    echo "         v.${VERSION}"
    printf "\e[0m\n"

}


function Asoft {
    if ! [ -d ${BASE_DIR}/asoft ] ; then
        wget -c $ASOFT -O - | tar -xz -C $BASE_DIR
        [ $? -ne 0 ] && net_error "asoft"
    fi
}



