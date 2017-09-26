#!/bin/env bash
#
# Helper functions for cower

WORKING_DIR=$HOME/Shares/buildzone

function install_cower {
    echo === cower is not available in your PATH, so I try to install it ===
    cd $WORKING_DIR
    git clone https://aur.archlinux.org/cower.git
    cd cower && makepkg -scCfi
}

function test_if_cower_is_available {
    command -v cower >/dev/null 2>&1 
}

