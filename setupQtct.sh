#!/bin/sh
#set qt5ct in non kde de
if [[ $XDG_CURRENT_DESKTOP != "KDE" ]]  && [[ $XDG_CURRENT_DESKTOP != "kde" ]]
then
    export QT_QPA_PLATFORMTHEME=qt5ct
fi
