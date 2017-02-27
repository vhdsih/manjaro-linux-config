#!/bin/bash

relative_location=`dirname $0`

dir=$relative_location/res/i3/

files=(
$HOME/.dmenurc
$HOME/.Xresources
$HOME/.i3
$HOME/.i3status.conf
$HOME/.config/terminator
$HOME/.gtkrc-2.0
$HOME/.conkyrc
$HOME/.config/morc_menu
$HOME/.config/rofi
$HOME/.config/gtk-2.0
$HOME/.config/gtk-3.0
$HOME/.config/qt5ct
)

backup() {
    for file in ${files[@]}
    do
        ls $file.bak > /dev/null
        if [ $? = 0 ]
        then
            echo $file.bak file exist, rm it
            rm -rf $file.bak
        fi
        echo mv $file to $file.bak
        mv $file $file.bak
    done;
}

apply_backup() {
    cp $dir/.dmenurc $HOME
    cp $dir/.Xresources $HOME
    cp -r $dir/.i3 $HOME
    cp $dir/.i3status.conf $HOME
    cp -r $dir/terminator $HOME/.config
    cp $dir/.conkyrc $HOME
    cp -r $dir/morc_menu $HOME/.config
    cp -r $dir/rofi $HOME/.config
    cp -r $dir/gtk-* $HOME/.config
    cp -r $dir/qt5ct $HOME/.config
    cp $dir/.gtkrc-2.0 $HOME
}

backup
apply_backup

