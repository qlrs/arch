#!/bin/sh
xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 3840x1080 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 1920x1080 --rotate normal --output DP-3 --off

pacmd set-card-profile 0 output:hdmi-stereo-extra3