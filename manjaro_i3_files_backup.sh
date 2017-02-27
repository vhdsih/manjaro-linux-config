#!/bin/bash

exec_location=`pwd`

relative_location=`dirname $0`

backup_dir=$relative_location/res/i3

backup_backup_dir=$relative_location/res/backup/i3

backup_backup() {
    if [ -d $backup_backup_dir ]
    then
        echo $backup_backup_dir exist
    else
        echo mkdir $backup_backup_dir
        mkdir -p $backup_backup_dir
    fi

    if [ -d $backup_dir ]
    then
        now=`date`
        echo mv $backup_dir to $backup_backup_dir/$now
        mkdir -p $backup_backup_dir/"$now"
        cp -r $backup_dir $backup_backup_dir/"$now"
        rm -rf $backup_dir
    fi
}

backup() {
    mkdir -p $backup_dir
    cp $HOME/.dmenurc $backup_dir
    cp $HOME/.Xresources $backup_dir
    cp $HOME/.i3status.conf $backup_dir
    cp $HOME/.conkyrc $backup_dir
    cp $HOME/.xprofile $backup_dir
    cp $HOME/.gtkrc-2.0 $backup_dir
    

    cp -r $HOME/.i3 $backup_dir
    cp -r $HOME/.config/morc_menu $backup_dir
    cp -r $HOME/.config/terminator $backup_dir
    cp -r $HOME/.config/rofi $backup_dir
    cp -r $HOME/.config/gtk-* $backup_dir
    cp -r $HOME/.config/qt5ct $backup_dir
}

backup_backup
backup

