#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

pacman_APP=$relative_location/pacman
yaourt_APP=$relative_location/yaourt
LOG=install.log

## print log
print_log() {
    echo -e  "\033[0;31;1m$1  \033[0m"
    echo $1 >> $LOG
}

install_software() {

    success_installed=0
    false_installed=0

    for app in $(cat $1)
    do
        clear
        print_log "==> Start to install $app"
        echo "$3 $2 -S $app"
        $3 $2 -S --noconfirm $app
        status=$?
        if [ $status = 0 ]
        then
            print_log "Installed:  $app"
            success_installed=`expr $have_been_installed + 1`
        else
            print_log "=> Error: $app"
            false_installed=`expr $not_be_installed + 1`
        fi
    done

    clear
    echo "-*- install work done for $1 -*-"
    echo ""
    print_log "-> information: $have_been_installed apps had been installed"
    print_log "-> information: $not_be_installed apps were not installed"
    echo ""
    echo "wait 3s please..."
    sleep 3
}


echo > $LOG

install_software $pacman_APP pacman sudo

install_software $yaourt_APP yaourt
