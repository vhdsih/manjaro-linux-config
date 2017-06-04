#!/bin/bash

exec_location=`pwd`

relative_location=`dirname $0`

backup_dir=$relative_location/res/etc

backup_backup_dir=$relative_location/res/backup/etc

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
    #cp /etc/locale.gen $backup_dir
    #cp /etc/pacman-mirrors.conf $backup_dir
    cp /etc/pacman.conf $backup_dir
    #cp /etc/X11/xorg.conf.d/70-synaptics.conf $backup_dir
    #cp /etc/profile $backup_dir
}

backup_backup
backup

