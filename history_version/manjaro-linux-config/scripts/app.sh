#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

pacman_APP=$relative_location/../res/app/pacman
aur_APP=$relative_location/../res/app/aur

pacman_APP_i3wm=$relative_location/../res/app/pacman-i3wm
aur_APP_i3wm=$relative_location/../res/app/aur-i3wm
LOG=$relative_location/../app.log

## print log
print_log() {
    echo -e  "\033[0;31;1m$1  \033[0m"
    echo $1 >> $LOG
}

processbar() {
    local current=$1; local total=$2;
    local maxlen=80; local barlen=62; local barlen1=64; local perclen=14;
    local format="%-${barlen1}s]%$((maxlen-barlen))s"
    local perc="[$current/$total]"
    local progress=$((current*barlen/total))
    local prog=$(for i in `seq 0 $progress`; do printf '#'; done)
    printf "\rProgress: $format" [$prog $perc
    echo ''
}
install_software() {

    have_been_installed=0
    not_be_installed=0

    linenu=$(cat $1 | wc -l)
    for app in $(cat $1)
    do
        clear
        processbar `expr $have_been_installed + $not_be_installed` $linenu
        print_log "==> Start to install $app"
        echo "$3 $2 -S --noconfirm $4 $app"
        $3 $2 -S --noconfirm $4 $app
        status=$?
        if [ $status = 0 ]
        then
            print_log "Installed:  $app"
            have_been_installed=`expr $have_been_installed + 1`
        else
            print_log "Error: $app"
            echo $relative_location
            notify-send -i 'error' -a "Error Information For Installing" $app 
            not_be_installed=`expr $not_be_installed + 1`
            sleep 1
        fi
    done

    clear
    processbar `expr $have_been_installed + $not_be_installed` $linenu
    echo "Information for $1"
    echo ""
    print_log "-> $have_been_installed apps had been installed"
    print_log "-> $not_be_installed apps were not installed"
    echo ""
    echo "Error Installed Apps:"
    cat $LOG | grep Error
    echo "wait 3s please..."
    sleep 3
}


echo > $LOG

install_software $pacman_APP pacman sudo \-\-needed

install_software $aur_APP yay

if [ -f "i3wm.flag" ]; then
    echo "Install Applications For i3wm"
    install_software $pacman_APP_i3wm pacman sudo \-\-needed
    install_software $aur_APP_i3wm yay
fi
