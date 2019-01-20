#!/bin/bash

function backup_files() {
    cat $1 | while read line
    do
        echo Dealing $line ...
        if [ -e $file.bak ]; then
            echo Remove $file.bak
            /usr/bin/rm -rf $file.bak
        fi
        if [ -e $file ]; then
            echo Move $file to $file.bak
            /usr/bin/mv $file $file.bak
        fi

    done
}

function backup_file() {
    echo Dealing $1 ...
    if [ -e $1.bak -a -e $1 ]; then
        echo Remove $1.bak
        /usr/bin/rm -rf $1.bak
    fi
    if [ -e $1 ]; then
        echo Move $1 to $1.bak
        /usr/bin/mv $1 $1.bak
    fi
}

function link() {
    echo Linking $1 to $2
    backup_file $2
    ln -sfn $1 $2
}


# print log
function print_log() {
    echo -e  "\033[0;31;1m==> $1\033[0m"
    echo $1 >> $2
}

# check software
function check_software() {
    echo "Checking app $1 ..."
    which $1 >> /dev/null
    if [ $? = 0 ]; then
        echo "-> $1 had been installed"
    else
        echo "-> $1 has not been installed, installing now"
        sudo $2 $1
    fi
}
# update system
function update_system() {
    check_software wget "pacman -S --noconfirm"
    sudo pacman -Syyu --noconfirm
}
