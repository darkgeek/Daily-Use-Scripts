#!/bin/bash

AMIXER="/usr/bin/amixer"

case "$1" in
    jack/headphone)
        case "$3" in
            plug)
                $AMIXER set 'Left Headphone Mixer Left DAC' unmute
                $AMIXER set 'Right Headphone Mixer Right DAC' unmute
                $AMIXER set 'Right Speaker Mixer Right DAC' mute
                $AMIXER set 'Left Speaker Mixer Left DAC' mute
                ;;
            unplug)
                $AMIXER set 'Left Headphone Mixer Left DAC' mute
                $AMIXER set 'Right Headphone Mixer Right DAC' mute
                $AMIXER set 'Right Speaker Mixer Right DAC' unmute
                $AMIXER set 'Left Speaker Mixer Left DAC' unmute
                ;;
        esac
        ;;
esac
