#!/bin/bash

exec_location=`pwd`

relative_location=`dirname $0`

backfile=$relative_location/../res/etc/pacman.conf

backup_backup() {
    if [ -f $backfile ]
    then
        mv $backfile $backfile.bak
    fi
}

backup() {
    cp /etc/pacman.conf $relative_location
}

backup_backup
backup

