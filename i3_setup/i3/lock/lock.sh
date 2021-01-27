#!/bin/bash

i3lock -p win -f -e -i ~/.config/i3/lock/deer.png

sleep 30; pgrep i3lock && xset dpms force off
