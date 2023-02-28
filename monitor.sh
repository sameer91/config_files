#!/bin/bash

xrandr --output HDMI-1 --mode 2560x1440

if grep -q "open" /proc/acpi/button/lid/LID0/state
then
    xrandr --output eDP-1 --auto --right-of HDMI-1
else
    xrandr --output eDP-1 --off
fi

echo "Set Display" > /tmp/amIRun.txt
