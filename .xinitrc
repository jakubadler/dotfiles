#!/bin/bash

#exec xfce4-session

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export GDK_USE_XFT=1
export QT_XFT=true

export OOO_FORCE_DESKTOP=gnome
#export AWT_TOOLKIT="MToolkit"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_OVERLAY_SCROLLING=0

export BROWSER=qutebrowser

xrdb -merge .Xresources

#xscreensaver -no-splash &
xautolock -locker '' -nowlocker slock &

#~/.screenlayout/doma.sh
/usr/local/bin/hotplug_monitor.sh
#set-mouse.sh

#hsetroot -center ~/.wallpaper &
#feh --bg-tile ~/.wallpaper &
xsetroot -solid black

#synclient TouchpadOff=1 &
#xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
#xinput --set-prop "Avago USB LaserStream(TM) Mouse" "Device Accel Constant Deceleration" 2
#/home/kuba/bin/set-mouse.sh &

tint2 &
#thinkhdaps &
#wicd-gtk -t &
nm-applet &
blueman-applet &
#xfce4-power-manager &
#xfce4-volumed &
#volti &
pulseaudio &
pasystray &
#xfce4-panel &

#xcompmgr -n &
#xcompmgr -c &

#start offlineimap
#offlineimap &

mpd &
mpdscribble --conf ~/.mpdscribble/mpdscribble.conf &

exec dbus-launch --exit-with-session xmonad
