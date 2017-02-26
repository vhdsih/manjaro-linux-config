#!/bin/bash

relative_location=`dirname $0`

dir=$relative_location/res/i3/

files=(
$HOME/.dmenurc
$HOME/.Xresources
$HOME/.i3
$HOME/.i3status.conf
$HOME/.config/terminator
$HOME/.conkyrc
$HOME/.config/morc_menu
)

backup() {
    for file in ${files[@]}
    do
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
}

backup
apply_backup

