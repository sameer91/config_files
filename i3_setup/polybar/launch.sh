#!/bin/bash

pkill polybar
sleep 2
polybar main &
#polybar --config=$HOME/.config/polybar/clock main&
