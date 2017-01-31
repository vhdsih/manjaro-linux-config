#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

pacman_APP=$relative_location/pacman 
yaourt_APP=$relative_location/yaourt 
LOG=$relative_location/log

## print log
print_log() {
    echo -e  "\033[0;31;1m INSTALL-LOGS: $1  \033[0m"
    echo LOGS: $1 >> $LOG
}

install_software() {

    success_installed=0
    false_installed=0

    for app in $(cat $1)
    do
        print_log "STARTING TO INSTALL $app"
        echo "$3 $2 -S $app"
        $3 $2 -S $app
        status=$?
        if [ $status = 0 ] 
        then
            print_log "SUCCESSFULLY INSTALLED"
            success_installed=`expr $success_installed + 1`
            print_log "[√]${app} WAS INSTALLED OR IT WAS EXIST"
        else
            print_log "ERROR WHEN INSTALL $app"
            false_installed=`expr $false_installed + 1`
            print_log "$app WAS NOT BE INATALLED"
        fi
    done

    # install information
        
    print_log "$success_installed APPLICATIONS WERE INSTALLED SUCCESSFULLY"
    print_log "$false_installed APPLICATIONS WERE NOT BE INSTALLED, PLEASE CHECK"
}


echo > $LOG

install_software $pacman_APP pacman sudo

install_software $yaourt_APP yaourt 
