#!/bin/bash


if [[ $(mpc current) ]];
   then
	   case $1 in
		   "toggle") mpc toggle;;
		   "next") mpc next;;
		   "previous") mpc prev;;
	   esac
else
	   case $1 in
		   "toggle") playerctl play-pause;;
		   "next") playerctl next;;
		   "previous") playerctl previous;;
	   esac
fi
