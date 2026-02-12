#!/bin/bash

#set hdmi active and shut down laptop screen --> homeoffice
if [[ "$1" == "hdmi" ]]; then
  xrandr --output HDMI-1-1 --primary --auto --output eDP-1 --off
else
  xrandr --output HDMI-1-1 --primary --auto --output eDP-1 --auto --left-of HDMI-1-1
fi
