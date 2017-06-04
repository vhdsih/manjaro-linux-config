#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

pacman_APP=$relative_location/pacman
yaourt_APP=$relative_location/yaourt
LOG=$relative_location/log

## print log
print_log() {
    echo -e  "\033[0;31;1mlog::install-app $1  \033[0m"
    echo log::install-app $1 >> $LOG
}

install_software() {

    success_installed=0
    false_installed=0

    for app in $(cat $1)
    do
        print_log "start to install $app"
        echo "$3 $2 -S $app"
        $3 $2 -S --noconfirm $app
        status=$?
        if [ $status = 0 ]
        then
            print_log "$app installed successfully!"
            success_installed=`expr $success_installed + 1`
        else
            print_log "error::install-error $app not be installed"
            false_installed=`expr $false_installed + 1`
        fi
    done

    # install information

    print_log "$success_installed apps had been installed"
    print_log "$false_installed apps were not installed"
}


echo > $LOG

install_software $pacman_APP pacman sudo

install_software $yaourt_APP yaourt
