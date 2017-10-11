#!/bin/env bash
#
# Helper functions for cower

WORKING_DIR=$HOME/Shares/buildzone
ARCH=`uname -m`

function install_cower {
    echo === cower is not available in your PATH, so I try to install it ===
    if [[ "$ARCH" == "armv7l" ]]; then
        pacman -S cower
    else
        if [ ! -d "$WORKING_DIR" ]; then
            mkdir -p $WORKING_DIR
        fi

        cd $WORKING_DIR
        git clone https://aur.archlinux.org/cower.git
        cd cower && makepkg -scCfi
    fi
}

function test_if_cower_is_available {
    command -v cower >/dev/null 2>&1 
}
