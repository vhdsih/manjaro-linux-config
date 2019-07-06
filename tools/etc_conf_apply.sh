#!/bin/bash

relative_location=`dirname $0`

dir=$relative_location

files=(
/etc/pacman.conf
/etc/proxychains.conf
)

backup() {
    for file in ${files[@]}
    do
        ls $file.bak
        if [ $? = 0  ]
        then
            echo $file.bak file exist, rm it
            sudo rm -rf $file.bak
        fi
        echo mv $file to $file.bak
        sudo mv $file $file.bak
    done;
}

apply_backup() {
    sudo cp $dir/pacman.conf /etc
    sudo cp $dir/proxychains.conf /etc
}

backup
apply_backup

